import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';
import 'package:weather_forecast/services/local_services.dart';

class MainForecastCard extends StatelessWidget {
  const MainForecastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.45)
      ),
      child: Consumer<ForecastNotifier>(
        builder: (context, forecastNot, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: Text('London', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),)),
              Center(child: Text(forecastNot.todayForecast.currTemperature, style: const TextStyle(fontSize: 60, letterSpacing: -1))),
              Image.network(
                forecastNot.todayForecast.icon, height: 150, fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              Text(LocalServices.capitalizeFirst(forecastNot.todayForecast.weatherDescription), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('Humidity: ${forecastNot.todayForecast.humidityPercentage}%'),
              Text('MAX: ${forecastNot.todayForecast.maxTemperature}'),
              Text('MIN: ${forecastNot.todayForecast.minTemperature}'),
              Text('Last update: ${forecastNot.todayForecast.requestDate}')
            ],
          );
        },
      ),
    );
  }
}