import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Components/SearchWeatherCard.dart';
import 'package:weather_app/ViewModel/HomeViewModel.dart';

class SearchView extends StatefulWidget {
  final HomeViewModel viewModel;
  const SearchView({super.key, required this.viewModel});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchSearchPageCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Weather",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),

                      // Search Input
                      const SizedBox(height: 15),
                      TextField(
                        onSubmitted: (value) =>
                            widget.viewModel.searchNewCity(value),
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search for a city",
                          hintStyle: const TextStyle(color: Colors.white38),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white38,
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      // Display temperatures in the list
                      Expanded(
                        child: widget.viewModel.isSearchLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 20),
                                itemCount: widget.viewModel.searchList.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      widget.viewModel.searchList[index];
                                  return SearchWeatherCard(
                                    temp: data.tempC.round().toString(),
                                    high: data.maxTemp.round().toString(),
                                    low: data.minTemp.round().toString(),
                                    city: "${data.cityName}, ${data.cityName}",
                                    condition: data.condition,
                                    iconPath: data.hourlyForecast[0].icon,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
