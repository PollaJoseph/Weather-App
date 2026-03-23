import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Components/SearchWeatherCard.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      body: Stack(
        children: [
          // Background Gradient/Image
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
                  // Custom App Bar
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

                  // Search Bar
                  const SizedBox(height: 20),
                  TextField(
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

                  // Weather List
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 20),
                      children: const [
                        SearchWeatherCard(
                          temp: "19",
                          high: "24",
                          low: "18",
                          city: "Montreal, Canada",
                          condition: "Mid Rain",
                          iconPath: "lib/Assets/Icons/Sun cloud mid rain.png",
                        ),
                        SearchWeatherCard(
                          temp: "20",
                          high: "21",
                          low: "-19",
                          city: "Toronto, Canada",
                          condition: "Fast Wind",
                          iconPath: "lib/Assets/Icons/Moon cloud fast wind.png",
                        ),
                        SearchWeatherCard(
                          temp: "13",
                          high: "16",
                          low: "8",
                          city: "Tokyo, Japan",
                          condition: "Showers",
                          iconPath:
                              "lib/Assets/Icons/Sun cloud angled rain.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
