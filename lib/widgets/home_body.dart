import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_forecast/models/forecast_model.dart';
import 'package:weather_forecast/models/forecast_notifier.dart';
import 'package:weather_forecast/services/local_services.dart';
import 'package:weather_forecast/services/remote_services.dart';
import 'package:weather_forecast/util/constants.dart';
import 'package:weather_forecast/widgets/cards/error_card.dart';
import 'package:weather_forecast/widgets/cards/main_weather_card.dart';
import 'package:weather_forecast/widgets/cards/five_days_forecast_card.dart';
import 'package:weather_forecast/widgets/secondary_info_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late Future<Forecast> futureForecast;
  @override
  void initState() {
    super.initState();
    futureForecast = RemoteServices.fetchCurrentForecast();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureForecast,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const ErrorCard(connectionErr: true);
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Image.asset('assets/images/Sun.gif');
          case ConnectionState.done:
            if (snapshot.data == null) {
              return const ErrorCard();
            } else {
              Forecast tmpForecast = snapshot.data as Forecast;
              context.read<ForecastNotifier>().initTodayForecast(tmpForecast);

              return Consumer<ForecastNotifier>(
                  builder: (context, forecastNot, child) {
                    if (forecastNot.isLoading) {
                      return Image.asset('assets/images/Sun.gif');

                    } else {
                      return ListView(
                        children: const [
                          MainForecastCard(),
                          SizedBox(height: 5),
                          SecondaryInfoWidget(),
                          SizedBox(height: 5),
                          FiveDaysForecastCard(),
                          SizedBox(height: 5),
                          OpenMapButton()
                        ],
                      );
                    }
                  });
            }
        }
      }
      );
  }
}

class OpenMapButton extends StatelessWidget {
  const OpenMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: Colors.black,
        onPressed: ()=> LocalServices.launchURL(Constants.webPage),
        child: const Text('Open weather map', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}