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
      // Map the code to your local asset folder
      icon: _mapCodeToAsset(json['condition']['code'], json['is_day'] == 1),
    );
  }

  static String _mapCodeToAsset(int code, bool isDay) {
    // WeatherAPI Codes: 1000 (Clear), 1003 (Partly Cloudy), etc.
    if (code == 1000) {
      return isDay
          ? "lib/Assets/Icons/Sun cloud mid rain.png" // Replace with your 'Clear' icon
          : "lib/Assets/Icons/Moon cloud fast wind.png";
    } else if (code >= 1063) {
      return isDay
          ? "lib/Assets/Icons/Sun cloud angled rain.png"
          : "lib/Assets/Icons/Moon cloud mid rain.png";
    }

    // Default fallback
    return "lib/Assets/Icons/Tornado.png";
  }
}
