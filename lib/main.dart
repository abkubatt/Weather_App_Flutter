import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
//import 'package:weather_app/screens/weather_forecast_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}

