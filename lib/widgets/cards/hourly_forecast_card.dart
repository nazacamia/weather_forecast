import 'package:flutter/material.dart';
import 'package:weather_forecast/models/forecast_model.dart';
import 'package:weather_forecast/services/local_services.dart';
import 'package:weather_forecast/widgets/daily_weather_container.dart';

class HourlyForecastCard extends StatelessWidget {
  final Forecast forecast;
  final int hourIndex;
  const HourlyForecastCard({Key? key, required this.forecast, required this.hourIndex}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.symmetric(
          vertical: BorderSide(width: 0.5),
          horizontal: BorderSide(width: 0.5),
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocalServices.getTime(hourIndex)),
          WeatherIcon(url: forecast.icon, margin: const EdgeInsets.symmetric(vertical: 5),),
          Text(forecast.maxTemperature, style: const TextStyle(fontWeight: FontWeight.bold),),
          Text(forecast.minTemperature)
        ],
      ),
    );
  }
}