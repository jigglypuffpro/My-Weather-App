import 'package:flutter/material.dart';

class DetailedWeatherScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final List<dynamic> forecastData;

  DetailedWeatherScreen({required this.weatherData, required this.forecastData});

  String getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'assets/icons/clear_sky.png';
      case 'few clouds':
        return 'assets/icons/few_clouds.png';
      case 'scattered clouds':
        return 'assets/icons/scattered_clouds.png';
      case 'broken clouds':
        return 'assets/icons/broken_clouds.png';
      case 'shower rain':
        return 'assets/icons/shower_rain.png';
      case 'rain':
        return 'assets/icons/rain.png';
      case 'thunderstorm':
        return 'assets/icons/thunderstorm.png';
      case 'snow':
        return 'assets/icons/snow.png';
      case 'mist':
        return 'assets/icons/mist.png';
      default:
        return 'assets/icons/defalut.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details in ${weatherData['name']}'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Temperature: ${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Weather: ${weatherData['weather'][0]['description']}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Humidity: ${weatherData['main']['humidity']}%',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Wind Speed: ${weatherData['wind']['speed']} m/s',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'Forecast for the next few days',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  final forecast = forecastData[index];
                  final date = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
                  final temperature = (forecast['main']['temp'] - 273.15).toStringAsFixed(2);
                  final description = forecast['weather'][0]['description'];
                  final iconPath = getWeatherIcon(description);

                  return ListTile(
                    leading: Image.asset(iconPath, width: 50, height: 50),
                    title: Text(
                      '${date.toLocal()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Temp: $temperature °C\nDescription: $description'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
