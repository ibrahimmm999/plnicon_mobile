import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultRadius = 12.0;
double defaultMargin = 16.0;

Color neutral50 = const Color(0xffFAFAFF);
Color neutral100 = const Color(0xffEEF0F2);
Color neutral300 = const Color(0xffECEBE4);
Color neutral500 = const Color(0xffDADDD8);
Color neutral600 = const Color(0xff6B6B6B);
Color neutral700 = const Color(0xff1C1C1C);

Color textDarkColor = const Color(0xff031B34);
Color textLightColor = const Color(0xffF8F8F8);

Color primaryYellow = const Color(0xffF8DB25);
Color primaryBlue = const Color(0xff09AEEF);
Color primaryRed = const Color(0xffBD1B1B);
Color primaryGreen = const Color(0xff1D7331);

Color hoverYellow = const Color(0xffFFEA6A);
Color hoverBlue = const Color(0xff59C6F1);
Color hoverRed = const Color(0xffE64444);
Color hoverGreen = const Color(0xff34AA4F);

Color clickYellow = const Color(0xffE5B91D);
Color clickBlue = const Color(0xff0B7AA6);
Color clickRed = const Color(0xffA40404);
Color clickGreen = const Color(0xff004F12);

TextStyle header1 = GoogleFonts.montserrat(
  color: textDarkColor,
  fontSize: 36,
  fontWeight: bold,
);
TextStyle header2 = GoogleFonts.montserrat(
  color: textDarkColor,
  fontSize: 24,
  fontWeight: bold,
);
TextStyle header3 = GoogleFonts.montserrat(
  color: textDarkColor,
  fontSize: 16,
  fontWeight: bold,
);
TextStyle body = GoogleFonts.montserrat(
  color: textDarkColor,
  fontSize: 16,
  fontWeight: regular,
);
TextStyle buttonText = GoogleFonts.montserrat(
  color: textLightColor,
  fontSize: 16,
  fontWeight: semibold,
);
TextStyle linkText = GoogleFonts.montserrat(
    color: textDarkColor,
    fontSize: 12,
    fontWeight: semibold,
    decoration: TextDecoration.underline);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
