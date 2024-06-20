import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider with ChangeNotifier {
  static const apiKey = '8af91e57da926c657b6702a121c91855';
  static const currentWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Map<String, dynamic>? _weatherData;
  List<dynamic>? _forecastData;
  bool _isLoading = false;

  Map<String, dynamic>? get weatherData => _weatherData;
  List<dynamic>? get forecastData => _forecastData;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    final queryParams = {
      'q': city,
      'appid': apiKey,
    };

    try {
      final uri = Uri.parse('$currentWeatherUrl?q=${queryParams['q']}&appid=${queryParams['appid']}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _weatherData = jsonData;
      } else {
        _weatherData = null;
        print('Error fetching weather data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
      _weatherData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchForecast(String city) async {
    _isLoading = true;
    notifyListeners();

    final queryParams = {
      'q': city,
      'appid': apiKey,
    };

    try {
      final uri = Uri.parse('$forecastUrl?q=${queryParams['q']}&appid=${queryParams['appid']}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _forecastData = jsonData['list'];
      } else {
        _forecastData = null;
        print('Error fetching forecast data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching forecast data: $error');
      _forecastData = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
