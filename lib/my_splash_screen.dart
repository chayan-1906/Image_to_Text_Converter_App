import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: const HomeScreen(),
      title: Text(
        'Image to Text Converter',
        textAlign: TextAlign.center,
        style: GoogleFonts.getFont(
          'Source Serif Pro',
          fontWeight: FontWeight.w600,
          color: Colors.deepOrangeAccent,
          fontSize: 40.0,
        ),
      ),
      image: Image.asset('assets/images/imagetext.png'),
      photoSize: 130.0,
      backgroundColor: Colors.white,
      useLoader: true,
      loaderColor: Colors.pinkAccent,
      loadingText: Text(
        'Padmanabha Das',
        textAlign: TextAlign.end,
        style: GoogleFonts.getFont(
          'Dancing Script',
          fontWeight: FontWeight.w600,
          color: Colors.pinkAccent,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
