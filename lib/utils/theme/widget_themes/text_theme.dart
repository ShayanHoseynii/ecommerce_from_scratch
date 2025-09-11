import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';

class TTextTheme {
  TTextTheme._(); // prevent instantiation

  /* -- Light Text Theme -- */
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: 0.3,
      color: TColors.dark,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.2,
      color: TColors.dark,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: TColors.dark,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: TColors.dark,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: TColors.dark,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: TColors.dark,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: TColors.dark,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: TColors.dark.withOpacity(0.8),
    ),
  );

  /* -- Dark Text Theme -- */
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: 0.3,
      color: TColors.white,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.2,
      color: TColors.white,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: TColors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: TColors.white,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: TColors.white,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: TColors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: TColors.white.withOpacity(0.8),
    ),
  );
}
