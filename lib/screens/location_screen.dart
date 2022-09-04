import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/screens/weather_forecast_screen.dart';
//import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherForecast();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherForecastScreen(locationWeather: weatherInfo);
      }));
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentTag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black87,
          size: 100,
        ),
      ),
    );
  }
}
