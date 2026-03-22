import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String time;
  final String temperature;
  final String icon;
  final bool isSelected;
  final String? chanceOfRain;

  const WeatherCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    this.isSelected = false,
    this.chanceOfRain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75, // Slightly wider for the pill shape
      height: 160, // Taller to match the UI
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        // Use a gradient for the selected state
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5936B4), Color(0xFF362A84)],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
        border: Border.all(
          color: isSelected
              ? Colors.white.withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF5936B4).withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Weather Icon + Rain Percent
          SizedBox(
            height: 65, // Fixed height to keep icons aligned
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, height: 40, width: 40),
                if (chanceOfRain != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      chanceOfRain!,
                      style: const TextStyle(
                        color: Color(0xFF40CBD8), // Teal/Cyan color from image
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Text(
            "$temperature°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
