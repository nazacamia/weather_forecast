import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';
import 'package:weather_forecast/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255,204,0,1)
        ),
        child: const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: HomeBody(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.black,
        onPressed: ()=> context.read<ForecastNotifier>().updateTodayForecast(),
        tooltip: 'Reaload',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}