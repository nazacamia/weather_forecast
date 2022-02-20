import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';
import 'package:weather_forecast/views/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ForecastNotifier(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}