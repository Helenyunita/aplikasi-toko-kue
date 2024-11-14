import 'package:flutter/material.dart';

// Warna tema utama
final Color primaryColor = Color(0xFFFFC1E3);
final Color secondaryColor = Color(0xFFB3E5FC);

// Tema aplikasi
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: secondaryColor,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black54),
  ),
);

// BoxDecoration untuk Container
final BoxDecoration containerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3), // Posisi bayangan
    ),
  ],
);
