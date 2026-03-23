import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: 75,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
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
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Weather Icon + Rain Percent
          SizedBox(
            height: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, height: 40, width: 40),
                if (chanceOfRain != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      chanceOfRain!,
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF40CBD8),
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
            style: GoogleFonts.montserrat(
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
