import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:weather_forecast/models/forecast_model.dart';
import 'package:weather_forecast/services/remote_services.dart';

class ForecastNotifier extends ChangeNotifier{

  bool isLoading = false;

  bool hasError = false;

  /// Today's weather
  late Forecast _today;

  /// List of next five days weather forecast
  final List<Forecast> _forecastList = [];

  /// Map<key, value>
  ///
  /// key = day
  /// value = list of 8 forecast objects, representing 8 time intervals of a day
  ///
  /// each day (key) is associated with a list of Forecast objects
  /// every single Forecast object represent the Forecast for the given day interval
  late final Map<String, dynamic> forecastMap = {};

  UnmodifiableListView<Forecast> get forecastList => UnmodifiableListView(_forecastList);

  Forecast get todayForecast => _today;

  Map<String, dynamic> get fiveDaysMap => forecastMap;

  /// Returns forecastMap's keys, which are the next five days
  Iterable<String> get mapKeys => forecastMap.keys;

  List<Forecast> get fiveDaysForecast => _forecastList;


  /// Initialize today's forecast
  void initTodayForecast(Forecast forecast) {
    _today = forecast;
  }

  /// Initialize today's and next 4 days weather forecast
  void initFiveDaysForecast(List<Forecast> newList) {
    _forecastList.clear();
    _forecastList.addAll(newList);
    for (int i=0; i<newList.length; i++) {
      if ((i%8==0 || i==0)) {
        forecastMap[newList[i].date.toString()] = [
          for (int j=0; j<8; j++)
            newList[i+j]
        ];
      }
    }
  }

  /// Updates today's and next 4 days weather forecast
  void updateTodayForecast() async {
    toggleLoading();
    try {
      Forecast tmpForecast = await RemoteServices.fetchCurrentForecast();
      _today = tmpForecast;
      List<Forecast> tmpForecastList = await RemoteServices.fetchFiveDayForecast();
      _forecastList.clear();
      if (tmpForecastList.isNotEmpty) {
        _forecastList.addAll(tmpForecastList);
      }
    } catch (err) {
      hasError = true;
    } finally {
      toggleLoading();
    }
  }

  void toggleLoading() {
    isLoading=!isLoading;
    notifyListeners();
  }
}