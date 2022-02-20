import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_forecast/models/forecast_model.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';
import 'package:weather_forecast/services/remote_services.dart';
import 'package:weather_forecast/widgets/cards/error_card.dart';
import 'package:weather_forecast/widgets/daily_weather_container.dart';

class FiveDaysForecastCard extends StatefulWidget {
  const FiveDaysForecastCard({Key? key}) : super(key: key);

  @override
  _FiveDaysForecastCardState createState() => _FiveDaysForecastCardState();
}

class _FiveDaysForecastCardState extends State<FiveDaysForecastCard> {
  late Future<List<Forecast>> futureForecastList;

  @override
  void initState() {
    super.initState();
    futureForecastList = RemoteServices.fetchFiveDayForecast();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureForecastList,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return const ErrorCard(connectionErr: true);

          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(child: LinearProgressIndicator(),);

          case ConnectionState.done:
          default:
            if (snapshot.data == null) {
              return const ErrorCard();
            } else {
              List<Forecast> tmpList = snapshot.data as List<Forecast>;
              context.read<ForecastNotifier>().initFiveDaysForecast(tmpList);
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.45)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(CupertinoIcons.calendar),
                        SizedBox(width: 5),
                        Text('5-DAYS FORECAST')
                      ],
                    ),
                    const Divider(color: Colors.white,),
                    Column(
                      children: [
                        for (String tmpDay in context.read<ForecastNotifier>().mapKeys)
                          DailyWeatherContainer(
                              forecastHourlyList: context.read<ForecastNotifier>().fiveDaysMap[tmpDay],
                              isFirst: tmpDay==context.read<ForecastNotifier>().mapKeys.first
                          )
                      ]
                    )
                  ]
                )
              );
            }
        }
      }
    );
  }
}