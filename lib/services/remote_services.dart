import 'package:weather_forecast/models/forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/util/constants.dart';
import 'dart:convert';

class RemoteServices {
  static Future<Forecast> fetchCurrentForecast({String city='London'}) async {
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${Constants.apiKey}');
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      Map<String, dynamic> body = json.decode(response.body);
      Forecast tmpForecast = Forecast.fromMap(body);
      return tmpForecast;
    }
    return Forecast.fromMap({'id': -1});
  }

  static Future<List<Forecast>> fetchFiveDayForecast({String city='London'}) async {
    List<Forecast> forecastList = [];
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=London&appid=${Constants.apiKey}');
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      Map<String, dynamic> body = json.decode(response.body);
      for (Map<String, dynamic> item in body['list']) {
        Forecast tmpForecastItem = Forecast.fromMap(item);
        forecastList.add(tmpForecastItem);
      }
      return forecastList;
    }
    return forecastList;
  }
}