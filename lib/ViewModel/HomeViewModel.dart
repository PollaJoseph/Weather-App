import 'package:flutter/material.dart';
import 'package:weather_app/API/WeatherService.dart';
import 'package:weather_app/Model/WeatherModel.dart';

class HomeViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  // Change name to 'weather' to match your Model
  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;

  // Ensure this accepts a String argument
  Future<void> fetchWeather(String city) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _weatherService.getForecast(city);
      weather = WeatherModel.fromJson(response.data);
    } catch (e) {
      errorMessage = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
