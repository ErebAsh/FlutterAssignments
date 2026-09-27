import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../services/weather_api_service.dart';

/// Mini Project: Weather Forecast App
/// Requirements:
/// - Connect to OpenWeather API
/// - Display temperature, humidity, and weather icons for any city
/// - Use loading indicators and error handling
class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  final WeatherApiService _weatherService = WeatherApiService();
  final TextEditingController _cityController = TextEditingController(text: 'Delhi');

  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _quickCities = const [
    'Delhi',
    'Mumbai',
    'London',
    'New York',
    'Tokyo',
    'Paris',
  ];

  @override
  void initState() {
    super.initState();
    _fetchWeather('Delhi');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather(String city) async {
    final query = city.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _weatherService.fetchWeather(query);
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showApiKeyDialog() {
    final keyController =
        TextEditingController(text: _weatherService.openWeatherApiKey ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('OpenWeather API Key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'By default, the app uses live global geocoding + open meteorological API without needing any key. You can also paste your personal OpenWeather key below:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: 'OpenWeather API Key (Optional)',
                hintText: 'e.g. 2b9a7f3e...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _weatherService.openWeatherApiKey = null;
              Navigator.pop(ctx);
              _fetchWeather(_cityController.text);
            },
            child: const Text('Reset to Default'),
          ),
          FilledButton(
            onPressed: () {
              final val = keyController.text.trim();
              _weatherService.openWeatherApiKey = val.isNotEmpty ? val : null;
              Navigator.pop(ctx);
              _fetchWeather(_cityController.text);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny_rounded;
      case 'partly cloudy':
      case 'clouds':
        return Icons.cloud_queue_rounded;
      case 'overcast':
        return Icons.cloud_rounded;
      case 'rain':
      case 'rain showers':
        return Icons.water_drop_rounded;
      case 'thunderstorm':
        return Icons.thunderstorm_rounded;
      case 'snow':
        return Icons.ac_unit_rounded;
      case 'fog':
        return Icons.blur_on_rounded;
      default:
        return Icons.wb_cloudy_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar & API config button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _fetchWeather,
                      decoration: InputDecoration(
                        hintText: 'Enter city name (e.g. London, Delhi)...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.arrow_forward_rounded),
                          onPressed: () => _fetchWeather(_cityController.text),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    tooltip: 'Configure OpenWeather API Key',
                    icon: const Icon(Icons.key_rounded),
                    onPressed: _showApiKeyDialog,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Quick City Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _quickCities.map((c) {
                    final isCurrent =
                        _weatherData?.cityName.toLowerCase() == c.toLowerCase();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        avatar: isCurrent
                            ? const Icon(Icons.location_on, size: 14)
                            : null,
                        label: Text(c),
                        onPressed: () {
                          _cityController.text = c;
                          _fetchWeather(c);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Loading Indicator
              if (_isLoading)
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Fetching real-time weather & forecast...'),
                        ],
                      ),
                    ),
                  ),
                )
              // Error Handling Display
              else if (_errorMessage != null)
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: colorScheme.error.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline_rounded,
                            size: 54, color: colorScheme.error),
                        const SizedBox(height: 14),
                        Text(
                          'Weather Error',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: () => _fetchWeather(_cityController.text),
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              // Weather Details Display
              else if (_weatherData != null) ...[
                // Main Hero Weather Card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1A2980),
                          Color(0xFF26D0CE),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_weatherData!.cityName}${_weatherData!.country.isNotEmpty ? ", ${_weatherData!.country}" : ""}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _weatherData!.description.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Weather Icon
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getWeatherIcon(_weatherData!.condition),
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Big Temperature
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weatherData!.temperature.toStringAsFixed(1)}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Celsius (C)', style: TextStyle(color: Colors.white70, fontSize: 13)),
                                  Text(
                                    'Feels like ${_weatherData!.feelsLike.toStringAsFixed(1)}°',
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Metrics Grid (Humidity, Wind, Pressure)
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricTile(
                        context,
                        title: 'Humidity',
                        value: '${_weatherData!.humidity}%',
                        icon: Icons.water_drop_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricTile(
                        context,
                        title: 'Wind Speed',
                        value: '${_weatherData!.windSpeed.toStringAsFixed(1)} km/h',
                        icon: Icons.air_rounded,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricTile(
                        context,
                        title: 'Pressure',
                        value: '${_weatherData!.pressure} hPa',
                        icon: Icons.speed_rounded,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 5-Day Forecast Header & Cards
                Text(
                  '5-Day Weather Forecast',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _weatherData!.forecast.map((f) {
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                f.dayName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Icon(
                                _getWeatherIcon(f.condition),
                                size: 28,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${f.temp.toStringAsFixed(0)}°C',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                f.condition,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Icon(icon, size: 16),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
