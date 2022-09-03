import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  const TempView({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var temp = forecastList[0].temp.day.toStringAsFixed(0);
    var icon = forecastList[0].getIconUrl();
    var description = forecastList[0].weather[0].description.toUpperCase();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(icon, scale: 0.4, color: Colors.black87),
          SizedBox(width: 20),
          Column(
            children: [
              Text(
                '$temp °C',
                style: TextStyle(
                  fontSize: 54,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$description',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    );
  }
}
