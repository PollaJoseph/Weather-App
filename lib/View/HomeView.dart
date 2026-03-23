import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Components/WeatherCard.dart';
import 'package:weather_app/Model/WeatherModel.dart';
import 'package:weather_app/View/SearchView.dart';
import 'package:weather_app/ViewModel/HomeViewModel.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchWeather("Cairo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      body: ListenableBuilder(
        listenable: widget.viewModel, // Use widget.viewModel
        builder: (context, _) {
          // Since we are fetching in Splash, we can check if data is null
          // instead of showing a full-screen loader here
          final weather = widget.viewModel.weather;
          if (weather == null) {
            return const SizedBox(); // Or a very subtle loading state
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "lib/Assets/Images/Background Image.png",
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.32,
                  ),
                  child: Image.asset(
                    "lib/Assets/Images/House.png",
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      weather.cityName,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 34,
                      ),
                    ),
                    Text(
                      "${weather.tempC.round()}°",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 90,
                        fontWeight: FontWeight.w100,
                        height: 0.9,
                      ),
                    ),
                    Text(
                      weather.condition,
                      style: GoogleFonts.montserrat(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "H:${weather.maxTemp.round()}°  L:${weather.minTemp.round()}°",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),

                    const Spacer(),
                    _buildBottomPanel(weather.hourlyForecast),
                  ],
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchView(viewModel: viewModel),
                          ),
                        );
                      },
                      child: Image.asset(
                        "lib/Assets/Icons/Search Icon.png",
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomPanel(List<HourForecast> hourly) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF48319D).withOpacity(0.25),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hourly Forecast",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.access_time, color: Colors.white38, size: 18),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white10,
                thickness: 1,
                indent: 32,
                endIndent: 32,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: hourly.length,
                  itemBuilder: (context, index) {
                    final hour = hourly[index];
                    return WeatherCard(
                      time: hour.time,
                      temperature: hour.tempC.round().toString(),
                      icon: hour.icon,
                      isSelected: index == 0,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
