import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image/Pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double len = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      splashIconSize: len / 2,
      backgroundColor: const Color.fromARGB(255, 252, 184, 152),
      nextScreen: const HomePage(),
      splash: 'logo.png',
    );
  }
}
