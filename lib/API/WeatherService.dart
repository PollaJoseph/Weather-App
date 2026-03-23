import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.weatherapi.com/v1",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  static const String _apiKey = "696aadb9992444bdb12221725250503";

  Future<Response> getForecast(String city) async {
    try {
      final response = await _dio.get(
        "/forecast.json",
        queryParameters: {
          "key": _apiKey,
          "q": city,
          "days": "1",
          "aqi": "no",
          "alerts": "no",
        },
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("API Error: ${e.response?.data['error']['message']}");
      } else {
        throw Exception("Connection Error: ${e.message}");
      }
    }
  }
}
