import 'package:flutter/material.dart';
import 'package:image/Pages/download_page.dart';
import 'package:image/Pages/imagespage.dart';
import 'package:image/Pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ImagesPage.routeName: (context) => const ImagesPage(),
        DownloadPage.routeName: (context) => const DownloadPage()
      },
      title: 'Image',
      home: const SplashScreen(),
    );
  }
}
