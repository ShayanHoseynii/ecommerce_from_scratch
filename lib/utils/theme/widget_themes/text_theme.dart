import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart'; // Make sure this path is correct

class TTextTheme {
  TTextTheme._(); // prevent instantiation

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: TColors.dark,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: TColors.dark,
    ),

    headlineLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: TColors.dark,
    ),

    // --- UPDATED STYLES ---
    titleLarge: GoogleFonts.poppins(
      fontSize: 22, // Was 16px
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16, // Was 14px
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14, // Was 12px
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    // --- END OF UPDATES ---

    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: TColors.dark.withOpacity(0.87),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: TColors.dark.withOpacity(0.87),
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: TColors.dark.withOpacity(0.6),
    ),

    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: TColors.dark.withOpacity(0.87),
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: TColors.dark.withOpacity(0.87),
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: TColors.dark.withOpacity(0.6),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: TColors.white,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: TColors.white,
    ),

    headlineLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: TColors.white,
    ),

    // --- UPDATED STYLES ---
    titleLarge: GoogleFonts.poppins(
      fontSize: 22, // Was 16px
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16, // Was 14px
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14, // Was 12px
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    // --- END OF UPDATES ---

    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: TColors.white.withOpacity(0.87),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: TColors.white.withOpacity(0.87),
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: TColors.white.withOpacity(0.6),
    ),

    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: TColors.white.withOpacity(0.87),
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: TColors.white.withOpacity(0.87),
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: TColors.white.withOpacity(0.6),
    ),
  );
}