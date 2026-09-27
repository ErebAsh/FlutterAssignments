import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

/// Weather API Service for Week 3 Mini Project
/// Supports:
/// 1. Direct OpenWeather API (when an API key is provided)
/// 2. Live Global Geocoding & Meteorological API (Open-Meteo) for instant zero-key live weather
class WeatherApiService {
  String? openWeatherApiKey;

  WeatherApiService({this.openWeatherApiKey});

  Future<WeatherData> fetchWeather(String cityName) async {
    final trimmedCity = cityName.trim();
    if (trimmedCity.isEmpty) {
      throw WeatherException('Please enter a city name.');
    }

    // Try OpenWeather API if key provided
    if (openWeatherApiKey != null && openWeatherApiKey!.trim().isNotEmpty) {
      try {
        final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$trimmedCity&units=metric&appid=${openWeatherApiKey!.trim()}',
        );
        final response = await http.get(url).timeout(const Duration(seconds: 8));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return WeatherData.fromOpenWeatherJson(data);
        } else if (response.statusCode == 404) {
          throw WeatherException('City "$trimmedCity" not found on OpenWeather.');
        }
      } catch (e) {
        if (e is WeatherException) rethrow;
        // Fallback to open endpoint below
      }
    }

    // Open live weather service (CORS-friendly, keyless, global)
    return await _fetchLiveMeteoWeather(trimmedCity);
  }

  Future<WeatherData> _fetchLiveMeteoWeather(String city) async {
    try {
      // 1. Geocoding
      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=en&format=json',
      );
      final geoRes = await http.get(geoUrl).timeout(const Duration(seconds: 8));

      if (geoRes.statusCode != 200) {
        throw WeatherException('Network error connecting to weather service.');
      }

      final geoData = jsonDecode(geoRes.body) as Map<String, dynamic>;
      final results = geoData['results'] as List<dynamic>?;

      if (results == null || results.isEmpty) {
        throw WeatherException('City "$city" not found. Check the spelling.');
      }

      final firstResult = results[0] as Map<String, dynamic>;
      final lat = firstResult['latitude'] as num;
      final lon = firstResult['longitude'] as num;
      final resolvedCity = firstResult['name'] as String? ?? city;
      final country = firstResult['country_code'] as String? ?? '';

      // 2. Fetch current weather and daily forecast
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,surface_pressure,wind_speed_10m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto',
      );
      final weatherRes = await http.get(weatherUrl).timeout(const Duration(seconds: 8));

      if (weatherRes.statusCode != 200) {
        throw WeatherException('Failed to retrieve forecast data.');
      }

      final weatherData = jsonDecode(weatherRes.body) as Map<String, dynamic>;
      final current = weatherData['current'] as Map<String, dynamic>? ?? {};
      final daily = weatherData['daily'] as Map<String, dynamic>? ?? {};

      final temp = (current['temperature_2m'] as num?)?.toDouble() ?? 24.0;
      final humidity = (current['relative_humidity_2m'] as num?)?.toInt() ?? 60;
      final wind = (current['wind_speed_10m'] as num?)?.toDouble() ?? 10.0;
      final pressure = (current['surface_pressure'] as num?)?.toInt() ?? 1012;
      final weatherCode = (current['weather_code'] as num?)?.toInt() ?? 0;

      final conditionInfo = _translateWeatherCode(weatherCode);

      // Forecast days
      final dailyCodes = (daily['weather_code'] as List<dynamic>?) ?? [];
      final dailyTemps = (daily['temperature_2m_max'] as List<dynamic>?) ?? [];
      final days = ['Today', 'Tomorrow', 'Day 3', 'Day 4', 'Day 5'];

      final List<ForecastDay> forecast = [];
      for (int i = 0; i < 5 && i < dailyCodes.length; i++) {
        final code = (dailyCodes[i] as num).toInt();
        final cInfo = _translateWeatherCode(code);
        final dTemp = i < dailyTemps.length ? (dailyTemps[i] as num).toDouble() : temp;
        forecast.add(ForecastDay(
          dayName: days[i],
          temp: dTemp,
          condition: cInfo['condition']!,
          iconCode: cInfo['icon']!,
        ));
      }

      return WeatherData(
        cityName: resolvedCity,
        country: country.toUpperCase(),
        temperature: temp,
        feelsLike: temp + (humidity > 70 ? 1.5 : -0.5),
        humidity: humidity,
        windSpeed: wind,
        pressure: pressure,
        condition: conditionInfo['condition']!,
        description: conditionInfo['description']!,
        iconCode: conditionInfo['icon']!,
        forecast: forecast.isNotEmpty ? forecast : WeatherData.generateSampleForecast(temp),
      );
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Failed to load weather: $e');
    }
  }

  Map<String, String> _translateWeatherCode(int code) {
    if (code == 0) {
      return {'condition': 'Clear', 'description': 'Clear Sky', 'icon': '01d'};
    } else if (code == 1 || code == 2) {
      return {'condition': 'Partly Cloudy', 'description': 'Mainly Clear & Few Clouds', 'icon': '02d'};
    } else if (code == 3) {
      return {'condition': 'Overcast', 'description': 'Overcast Skies', 'icon': '04d'};
    } else if (code >= 45 && code <= 48) {
      return {'condition': 'Fog', 'description': 'Foggy conditions', 'icon': '50d'};
    } else if (code >= 51 && code <= 67) {
      return {'condition': 'Rain', 'description': 'Showers / Rain', 'icon': '10d'};
    } else if (code >= 71 && code <= 77) {
      return {'condition': 'Snow', 'description': 'Snow Fall', 'icon': '13d'};
    } else if (code >= 80 && code <= 82) {
      return {'condition': 'Rain Showers', 'description': 'Heavy Showers', 'icon': '09d'};
    } else if (code >= 95) {
      return {'condition': 'Thunderstorm', 'description': 'Thunderstorm with Rain', 'icon': '11d'};
    }
    return {'condition': 'Clear', 'description': 'Sunny', 'icon': '01d'};
  }
}

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);

  @override
  String toString() => message;
}
