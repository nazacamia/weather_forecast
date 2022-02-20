import 'package:url_launcher/url_launcher.dart';
import 'package:weather_forecast/util/constants.dart';

class LocalServices {

  /// Capitalize string's first letter
  static String capitalizeFirst(String string){
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  /// Convert Kelvin Degrees to Celsius Degrees
  static String kelvinToCelsius(double temp){
    double celsiusTemp = temp - Constants.kelvinFactor;
    return '${celsiusTemp.toStringAsFixed(2)}°';
  }

  static Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Get name of the week from a date
  static String getDayName(DateTime date, bool isFirst) {
    if (isFirst) {
      return 'Today';
    }
    switch (date.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Sunday';

    }
  }

  /// Get start time of interva
  /// index = index of a day's interval
  static String getTime(int index) {
    switch(index) {
      case 0:
        return '00:00';
      case 1:
        return '03:00';
      case 2:
        return '06:00';
      case 3:
        return '09:00';
      case 4:
        return '12:00';
      case 5:
        return '15:00';
      case 6:
        return '18:00';
      default:
        return '21:00';
    }

  }
}