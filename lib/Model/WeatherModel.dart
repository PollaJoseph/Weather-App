class WeatherModel {
  final String cityName;
  final double tempC;
  final String condition;
  final String conditionIcon;
  final double maxTemp;
  final double minTemp;
  final List<HourForecast> hourlyForecast;
  final List<DayForecast> weeklyForecast; // Added this field

  WeatherModel({
    required this.cityName,
    required this.tempC,
    required this.condition,
    required this.conditionIcon,
    required this.maxTemp,
    required this.minTemp,
    required this.hourlyForecast,
    required this.weeklyForecast, // Added to constructor
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // 1. Declare the forecast list properly
    var forecastList = json['forecast']['forecastday'] as List;

    return WeatherModel(
      cityName: json['location']['name'],
      tempC: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      conditionIcon: "https:${json['current']['condition']['icon']}",
      // 2. Use the declared forecastList
      maxTemp: forecastList[0]['day']['maxtemp_c'].toDouble(),
      minTemp: forecastList[0]['day']['mintemp_c'].toDouble(),

      // Map the 7-day forecast
      weeklyForecast: forecastList.map((e) => DayForecast.fromJson(e)).toList(),

      // Map the hourly forecast for the first day
      hourlyForecast: (forecastList[0]['hour'] as List)
          .map((e) => HourForecast.fromJson(e))
          .toList(),
    );
  }
}

// 3. Added the missing DayForecast class
class DayForecast {
  final String date;
  final double avgTemp;
  final String icon;

  DayForecast({required this.date, required this.avgTemp, required this.icon});

  factory DayForecast.fromJson(Map<String, dynamic> json) {
    return DayForecast(
      date: json['date'], // Returns "2026-03-23"
      avgTemp: json['day']['avgtemp_c'].toDouble(),
      icon: "https:${json['day']['condition']['icon']}",
    );
  }
}

class HourForecast {
  final String time;
  final double tempC;
  final String icon;

  HourForecast({required this.time, required this.tempC, required this.icon});

  factory HourForecast.fromJson(Map<String, dynamic> json) {
    return HourForecast(
      time: json['time'].toString().split(' ')[1],
      tempC: json['temp_c'].toDouble(),
      icon: _mapCodeToAsset(json['condition']['code'], json['is_day'] == 1),
    );
  }

  static String _mapCodeToAsset(int code, bool isDay) {
    // 1. Clear / Sunny
    if (code == 1000) {
      return isDay
          ? "lib/Assets/Icons/Clear Weather.png"
          : "lib/Assets/Icons/Moon cloud fast wind.png";
    }

    // 2. Cloudy / Mist / Fog
    if (code == 1003 ||
        code == 1006 ||
        code == 1009 ||
        code == 1030 ||
        code == 1135) {
      return "lib/Assets/Icons/Cloud.png";
    }

    // 3. Rain (Patchy, Light, Moderate)
    if (code == 1063 ||
        code == 1180 ||
        code == 1183 ||
        code == 1186 ||
        code == 1189) {
      return isDay
          ? "lib/Assets/Icons/Sun cloud angled rain.png"
          : "lib/Assets/Icons/Moon cloud mid rain.png";
    }

    // 4. Heavy Rain / Torrential Rain
    if (code == 1192 || code == 1195 || code == 1243 || code == 1246) {
      return "lib/Assets/Icons/Sun cloud mid rain.png";
    }

    // 5. Thunderstorms / Bad Weather
    if (code == 1087 ||
        code == 1273 ||
        code == 1276 ||
        code == 1279 ||
        code == 1282) {
      return "lib/Assets/Icons/bad.png";
    }

    // 6. Snow / Sleet / Ice Pellets
    if (code == 1066 ||
        code == 1114 ||
        code == 1210 ||
        code == 1213 ||
        code == 1216 ||
        code == 1219 ||
        code == 1222 ||
        code == 1225) {
      return "lib/Assets/Icons/snow.png";
    }

    // 7. High Wind / Blustery
    if (code == 1050 || code == 1053) {
      return "lib/Assets/Icons/air.png";
    }

    return "lib/Assets/Icons/Tornado.png";
  }
}
