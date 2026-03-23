import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/View/HomeView.dart';
import 'package:weather_app/ViewModel/HomeViewModel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.fetchWeather("Cairo");

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView(viewModel: viewModel)),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "lib/Assets/Images/Background Image.png",
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/Assets/Images/House.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Weather",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "Forecast App",
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white70,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
