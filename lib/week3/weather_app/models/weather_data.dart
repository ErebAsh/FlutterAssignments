class ForecastDay {
  final String dayName;
  final double temp;
  final String condition;
  final String iconCode;

  ForecastDay({
    required this.dayName,
    required this.temp,
    required this.condition,
    required this.iconCode,
  });
}

class WeatherData {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String condition;
  final String description;
  final String iconCode;
  final List<ForecastDay> forecast;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.condition,
    required this.description,
    required this.iconCode,
    this.forecast = const [],
  });

  factory WeatherData.fromOpenWeatherJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weather = weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final sys = json['sys'] as Map<String, dynamic>? ?? {};

    return WeatherData(
      cityName: json['name'] as String? ?? 'Unknown City',
      country: sys['country'] as String? ?? '',
      temperature: (main['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (main['feels_like'] as num?)?.toDouble() ?? 0.0,
      humidity: (main['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      pressure: (main['pressure'] as num?)?.toInt() ?? 1013,
      condition: weather['main'] as String? ?? 'Clear',
      description: weather['description'] as String? ?? 'Clear Sky',
      iconCode: weather['icon'] as String? ?? '01d',
      forecast: generateSampleForecast((main['temp'] as num?)?.toDouble() ?? 25.0),
    );
  }

  static List<ForecastDay> generateSampleForecast(double baseTemp) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    final conditions = ['Clear', 'Clouds', 'Rain', 'Clear', 'Clouds'];
    final icons = ['01d', '02d', '10d', '01d', '03d'];

    return List.generate(5, (index) {
      return ForecastDay(
        dayName: days[index],
        temp: baseTemp + (index.isEven ? 1.5 : -1.0),
        condition: conditions[index],
        iconCode: icons[index],
      );
    });
  }
}
