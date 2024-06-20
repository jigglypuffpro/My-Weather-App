import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_profile_screen.dart';
import 'main_weather_screen.dart';
import 'welcome_screen.dart';
import 'weather_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Weather App',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        initialRoute: '/', // Set initial route to '/'
        routes: {
          '/': (context) => WelcomeScreen(), // Define '/' route to WelcomeScreen
          '/main': (context) => MainWeatherScreen(),
          '/profile': (context) => UserProfileScreen(),
        },
      ),
    );
  }
}
