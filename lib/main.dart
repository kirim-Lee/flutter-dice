import 'package:flutter/material.dart';
import 'package:gyro/colors.dart';
import 'package:gyro/screen/root_screen.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      sliderTheme: SliderThemeData(
        thumbColor: primaryColor,
        activeTrackColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(0.3),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        backgroundColor: backgroundColor,
      )
    ),
    home: RootScreen(),
  ));
}


