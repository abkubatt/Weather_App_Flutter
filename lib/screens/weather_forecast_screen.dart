import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/bottom_list_view.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/detail_view.dart';
import 'package:weather_app/widgets/temp_view.dart';

import '../api/weather_api.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  const WeatherForecastScreen({Key? key, this.locationWeather})
      : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastOjbect;
  String? _cityName;
  //String? _cityName;

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      forecastOjbect = Future.value(widget.locationWeather);
    }

    // forecastOjbect.then((weather) {
    //   print(weather.list[0].weather[0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.38),
        title: Text('openweathermap.org'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastOjbect = WeatherApi().fetchWeatherForecast();
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () async {
              var tappedName = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return CityScreen();
              }));
              if (tappedName != null) {
                setState(() {
                  _cityName = tappedName;
                  forecastOjbect = WeatherApi()
                      .fetchWeatherForecast(cityName: _cityName, isCity: true);
                });
              }
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          child: FutureBuilder<WeatherForecast>(
            future: forecastOjbect,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(height: 50),
                    CityView(snapshot: snapshot),
                    SizedBox(height: 50),
                    TempView(snapshot: snapshot),
                    SizedBox(height: 50),
                    DetailView(snapshot: snapshot),
                    SizedBox(height: 50),
                    BottomListView(snapshot: snapshot),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'City not found\nPlease, enter correct city',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ),
        )
      ]),
    );
  }
}
