import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Components/WeatherCard.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A), // Fallback background color
      body: Stack(
        children: [
          // Background Sky
          Positioned.fill(
            child: Image.asset(
              "lib/Assets/Images/Background Image.png",
              fit: BoxFit.cover,
            ),
          ),

          // The House Image
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.37,
              ),
              child: Image.asset(
                "lib/Assets/Images/House.png",
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Montreal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: 'WeatherFont',
                  ),
                ),
                const Text(
                  "19°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 96,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'WeatherFont',
                  ),
                ),
                Text(
                  "Mostly Clear",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "H:24°  L:18°",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),

                const Spacer(),

                // Bottom Panel (Reuse the WeatherCard component here)
                _buildBottomPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
      child: BackdropFilter(
        // This creates the blur effect on the layers behind the container
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 300, // Adjust height as needed
          width: double.infinity,
          decoration: BoxDecoration(
            // Semi-transparent purple/blue to match the vibe
            color: const Color(0xFF48319D).withOpacity(0.25),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2), // The thin "glass" edge
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // The little handle at the top of the modal
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

              // Forecast Tabs
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Weekly Forecast",
                      style: TextStyle(color: Colors.white38),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white10,
                thickness: 1,
                indent: 32,
                endIndent: 32,
              ),

              // Horizontal List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    WeatherCard(
                      time: "12 AM",
                      temperature: "19",
                      icon: "lib/Assets/Icons/Moon cloud fast wind.png",
                      chanceOfRain: "30%",
                    ),
                    WeatherCard(
                      time: "Now",
                      temperature: "19",
                      icon: "lib/Assets/Icons/Moon cloud fast wind.png",
                      isSelected: true,
                    ),
                    WeatherCard(
                      time: "2 AM",
                      temperature: "18",
                      icon: "lib/Assets/Icons/Moon cloud fast wind.png",
                    ),
                    WeatherCard(
                      time: "3 AM",
                      temperature: "19",
                      icon: "lib/Assets/Icons/Moon cloud fast wind.png",
                    ),
                    WeatherCard(
                      time: "4 AM",
                      temperature: "19",
                      icon: "lib/Assets/Icons/Moon cloud fast wind.png",
                    ),
                  ],
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
