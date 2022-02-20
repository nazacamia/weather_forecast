import 'package:weather_forecast/services/local_services.dart';

class Forecast {
  final int id;
  final String main;
  final String icon;
  final String weatherDescription;
  final String currTemperature;
  final String minTemperature;
  final String maxTemperature;
  final DateTime date;
  final DateTime requestDate;
  final int humidityPercentage;

  Forecast(this.id, this.main, this.icon, this.weatherDescription, this.currTemperature, this.minTemperature, this.maxTemperature, this.date, this.requestDate, this.humidityPercentage);


  factory Forecast.fromMap(Map<String, dynamic> data) {
    return Forecast(
        data['weather'].first['id'],
        data['weather'].first['main'],
        'https://openweathermap.org/img/wn/${data['weather'].first['icon']}@2x.png',
        data['weather'].first['description'],
        LocalServices.kelvinToCelsius((data['main']['temp'])),
        LocalServices.kelvinToCelsius((data['main']['temp_min'])),
        LocalServices.kelvinToCelsius((data['main']['temp_max'])),
        DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000),
        DateTime.now(),
        data['main']['humidity']
    );
  }

  factory Forecast.error(){
    return Forecast.fromMap({'id': -1});
  }
}