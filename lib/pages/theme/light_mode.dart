/*import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.yellow,//Color(0xFFE3DCCC), //background
    primary: Color.fromARGB(255, 248, 241, 223),
    secondary: Color.fromARGB(255, 139, 130, 111),
    inversePrimary: Color(0xFF62553B),
    inverseSurface:  Color(0xFFF3E6C6), // drawer
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.black,
    displayColor: Color(0xFF62553B)
  )
);*/


import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFF9F5E6),  // Soft cream background color
    primary: Color(0xFFE1D8B9),  // Light beige-yellowish color
    secondary: Color(0xFF8E7C53),  // Warm olive greenish tone
    inversePrimary: Color(0xFF6D5B38),  // Earthy dark brown-green
    inverseSurface:Color(0xFFF3E6C6),  // Lighter tan for drawer
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.black,  // Main text color
    displayColor: Color(0xFF6D5B38),  // Darker earth tones for headings and display
  ),
  appBarTheme: AppBarTheme(
    color: Color.fromARGB(255, 247, 239, 209),  // Light beige-yellowish for the app bar
    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 70, 58, 36),  // Dark brown for title text
      fontSize: 20,
      fontWeight: FontWeight.w600
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromARGB(255, 250, 240, 213),  // Use the secondary color for buttons
    textTheme: ButtonTextTheme.primary,
  ),
  cardColor: Color(0xFFF3E6C6),  // Use a soft cream for cards
);
