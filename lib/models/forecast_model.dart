import 'package:weather_forecast/services/local_services.dart';

class Forecast {
  final int id;
  final String main;
  final String icon;
  final String weatherDescription;
  final String currTemperature;
  final String minTemperature;
  final String maxTemperature;
  final String feelsLike;
  final DateTime date;
  final DateTime requestDate;
  final int humidityPercentage;
  final int visibility;
  final double windSpeed;
  final int windDeg;

  Forecast(this.id, this.main, this.icon, this.weatherDescription, this.currTemperature, this.minTemperature, this.maxTemperature, this.feelsLike, this.date, this.requestDate, this.humidityPercentage, this.visibility, this.windSpeed, this.windDeg);


  factory Forecast.fromMap(Map<String, dynamic> data) {
    return Forecast(
        data['weather'].first['id'],
        data['weather'].first['main'],
        'https://openweathermap.org/img/wn/${data['weather'].first['icon']}@2x.png',
        data['weather'].first['description'],
        LocalServices.kelvinToCelsius((data['main']['temp'])),
        LocalServices.kelvinToCelsius((data['main']['temp_min'])),
        LocalServices.kelvinToCelsius((data['main']['temp_max'])),
        LocalServices.kelvinToCelsius((data['main']['feels_like'])),
        DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000),
        DateTime.now(),
        data['main']['humidity'],
        data['visibility'],
        data['wind']['speed'],
        data['wind']['deg'],

    );
  }

  factory Forecast.error(){
    return Forecast.fromMap({'id': -1});
  }
}