import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Custom colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        brightness: Brightness.light,
      ),
      textTheme:
          GoogleFonts.rubikTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w600),
        displaySmall: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.rubik(
            color: Colors.black87, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.rubik(color: Colors.black87),
        bodyMedium: GoogleFonts.rubik(color: Colors.black87),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.rubik(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        labelStyle: GoogleFonts.rubik(color: Colors.black54),
      ),
      scaffoldBackgroundColor: Colors.grey[50],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        brightness: Brightness.dark,
      ),
      textTheme:
          GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w700),
        displayMedium:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w600),
        displaySmall:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w600),
        headlineMedium:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w600),
        headlineSmall:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w600),
        titleLarge:
            GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.rubik(color: Colors.white70),
        bodyMedium: GoogleFonts.rubik(color: Colors.white70),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.rubik(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.grey[800],
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[700],
        labelStyle: GoogleFonts.rubik(color: Colors.white70),
      ),
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}
