import 'package:flutter/material.dart';
import 'package:track_mitra/screens/home.dart';
import 'package:track_mitra/utils/colours.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Mitra',
      theme: ThemeData.dark().copyWith(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,

        primaryColor: Palette.kToDark,
        scaffoldBackgroundColor: Palette.kToDark,
      ),
      
      debugShowCheckedModeBanner: false,
      home: const HomePage()
    );
  }
}
