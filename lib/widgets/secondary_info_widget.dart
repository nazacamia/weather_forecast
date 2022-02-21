import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';

class SecondaryInfoWidget extends StatelessWidget {
  const SecondaryInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecondaryInfoCard(
              title: 'FEELS LIKE',
              icon: const Icon(Icons.thermostat_outlined, color: Colors.white, size: 15,),
              data: context.read<ForecastNotifier>().todayForecast.feelsLike
          ),
          SecondaryInfoCard(
              title: 'VISIBILITY',
              icon: const Icon(Icons.visibility, color: Colors.white, size: 15,),
              data: '${context.read<ForecastNotifier>().todayForecast.visibility.toString()} m'
          ),
          SecondaryInfoCard(
              title: 'WIND',
              icon: const Icon(CupertinoIcons.wind, color: Colors.white, size: 15,),
              data: '${context.read<ForecastNotifier>().todayForecast.windSpeed.toString()} m/s'
          ),

        ],
      ),
    );
  }
}

class SecondaryInfoCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String data;
  const SecondaryInfoCard({Key? key, required this.title, required this.icon, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/3.2,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          Row(
            children:  [
              icon,
              const SizedBox(width: 5,),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
            ],
          ),
          Text(data, style: const TextStyle(color: Colors.white, fontSize: 25),),
        ],
      ),
    );
  }
}