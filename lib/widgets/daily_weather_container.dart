import 'package:flutter/material.dart';
import 'package:weather_forecast/models/forecast_model.dart';
import 'package:weather_forecast/services/local_services.dart';
import 'package:weather_forecast/widgets/cards/hourly_forecast_card.dart';

class DailyWeatherContainer extends StatefulWidget {
  final List<Forecast> forecastHourlyList;
  final bool isFirst;
  const DailyWeatherContainer({Key? key, required this.forecastHourlyList, this.isFirst=false}) : super(key: key);

  @override
  State<DailyWeatherContainer> createState() => _DailyWeatherContainerState();
}

class _DailyWeatherContainerState extends State<DailyWeatherContainer> {
  late bool isExpanded;
  late String day;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
    day = LocalServices.getDayName(widget.forecastHourlyList.first.date, widget.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isExpanded? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
      padding: isExpanded? const EdgeInsets.fromLTRB(15,0,10,15) : const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: !isExpanded? null : const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.3)
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 85,child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold),)),
                const Spacer(),
                SizedBox(
                  width: 175,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      WeatherIcon(url: widget.forecastHourlyList.first.icon),
                      Text(LocalServices.capitalizeFirst(widget.forecastHourlyList.first.weatherDescription)),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(width: 60,child: Text(widget.forecastHourlyList.first.currTemperature)),
              ],
            ),
          ),
          if (isExpanded)
            SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.forecastHourlyList.length,
                  itemBuilder: (context, index) {
                    return HourlyForecastCard(forecast: widget.forecastHourlyList[index], hourIndex: index);
                  }),
            )
        ],
      ),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  final String url;
  final EdgeInsets margin;
  const WeatherIcon({Key? key, required this.url, this.margin=const EdgeInsets.only(right: 15)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: margin,
      decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.circle
      ),
      child: Image.network(
          url, height: 20, width: 20,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          }
      ),
    );
  }
}
