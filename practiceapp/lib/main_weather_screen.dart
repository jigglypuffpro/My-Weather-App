import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';
import 'detailed_weather_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainWeatherScreen extends StatefulWidget {
  @override
  _MainWeatherScreenState createState() => _MainWeatherScreenState();
}

class _MainWeatherScreenState extends State<MainWeatherScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _defaultCity;

  @override
  void initState() {
    super.initState();
    _getDefaultCity();
  }

  Future<void> _getDefaultCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _defaultCity = prefs.getString('homeCity');
      _searchController.text = _defaultCity ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _searchController.text;
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
                  Provider.of<WeatherProvider>(context, listen: false).fetchForecast(city);
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return Center(child: LinearProgressIndicator());
                }
                if (weatherProvider.weatherData == null) {
                  return Center(child: Text('No weather data available.'));
                }
                final weatherData = weatherProvider.weatherData!;
                return Column(
                  children: [
                    Text(
                      'Weather in ${weatherData['name']}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      weatherData['weather'][0]['description'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedWeatherScreen(
                              weatherData: weatherData,
                              forecastData: weatherProvider.forecastData!,
                            ),
                          ),
                        );
                      },
                      child: Text('View Details'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
