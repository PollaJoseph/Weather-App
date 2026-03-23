import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWeatherCard extends StatelessWidget {
  final String temp, high, low, city, condition, iconPath;

  const SearchWeatherCard({
    super.key,
    required this.temp,
    required this.high,
    required this.low,
    required this.city,
    required this.condition,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. The Slanted Background Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 150,
            child: Image.asset(
              "lib/Assets/Images/Rectangle 1.png",
              fit: BoxFit.fill,
            ),
          ),

          // 2. Temperature (Top Left)
          Positioned(
            left: 20,
            top: 45,
            child: Text(
              "$temp°",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.w200,
                height: 1.0,
              ),
            ),
          ),

          // 3. High & Low Temps (Middle Left)
          Positioned(
            left: 20,
            top: 115,
            child: Text(
              "H:$high°  L:$low°",
              style: GoogleFonts.montserrat(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // 4. City Name (Bottom Left)
          Positioned(
            left: 20,
            bottom: 15,
            child: Text(
              city,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 5. Floating 3D Icon (Top Right)
          Positioned(
            right: -1,
            top: -10,
            child: Image.asset(
              iconPath,
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),

          // 6. Condition Text (Bottom Right)
          Positioned(
            right: 30,
            bottom: 15,
            child: Text(
              condition,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
