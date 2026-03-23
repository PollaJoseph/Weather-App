import 'package:flutter/material.dart';
import 'package:weather_app/API/WeatherService.dart';
import 'package:weather_app/Model/WeatherModel.dart';

class HomeViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;

  List<WeatherModel> searchList = [];
  bool isSearchLoading = false;

  final List<String> _defaultCities = [
    "New York",
    "Tokyo",
    "Beijing",
    "Berlin",
    "Paris",
  ];

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

  Future<void> fetchSearchPageCities() async {
    isSearchLoading = true;
    searchList.clear();
    notifyListeners();

    try {
      final futures = _defaultCities.map(
        (city) => _weatherService.getForecast(city),
      );
      final responses = await Future.wait(futures);

      searchList = responses
          .map((res) => WeatherModel.fromJson(res.data))
          .toList();
    } catch (e) {
      errorMessage = "Could not load search cities: $e";
    } finally {
      isSearchLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchNewCity(String city) async {
    if (city.isEmpty) return;

    isSearchLoading = true;
    notifyListeners();

    try {
      final response = await _weatherService.getForecast(city);
      final newCity = WeatherModel.fromJson(response.data);

      searchList.removeWhere(
        (item) => item.cityName.toLowerCase() == city.toLowerCase(),
      );
      searchList.insert(0, newCity);
    } catch (e) {
      errorMessage = "City not found: $city";
    } finally {
      isSearchLoading = false;
      notifyListeners();
    }
  }
}
