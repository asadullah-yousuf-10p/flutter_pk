import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ColorDictionary {
  static const Map<String, Color> stringToColor = {
    'indigo': Colors.indigo,
    'green': Colors.green,
    'amber': Colors.amber,
    'blue': Colors.blue,
    'white': Colors.white,
    'black': Colors.black,
    'blueGrey': Colors.blueGrey,
    'lightBlue': Colors.lightBlue,
    'brown': Colors.brown,
    'teal': Colors.teal,
    'indigoAccent': Colors.indigoAccent,
    'grey': Colors.grey
  };
}

const double kCardBorderRadius = 8;
const Color kPink = Color(0xffe10a7d);
const Color kGreen = Color(0xff79cbbd);
const Color kBlue = Color(0xff3c1fa6);
const Color kBlueDark = Color(0xff1b0b56);

final theme = _buildTheme();

ThemeData _buildTheme() {
  var base = ThemeData.light();

  return base.copyWith(
    textTheme: TextTheme(
      display1: GoogleFonts.roboto(
          color: kPink, fontSize: 15, fontWeight: FontWeight.w400,letterSpacing: -0.15),
      body1: GoogleFonts.roboto(
          color: kPink, fontSize: 26, fontWeight: FontWeight.w300),
      headline: GoogleFonts.montserrat(
          color: kPink, fontSize: 26, fontWeight: FontWeight.w600),
      button: TextStyle(color: Colors.white, fontSize: 15),
      subhead: GoogleFonts.roboto(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      subtitle: GoogleFonts.roboto(
          color: kPink, fontSize: 15, fontWeight: FontWeight.w400),
      caption: GoogleFonts.roboto(
          color: kGreen, fontSize: 12, fontWeight: FontWeight.w500),
    ),
    primaryColor: kPink,
    accentColor: kPink,
    primaryColorDark: Color(0xffc8016b),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Color(0xffEDF1FA),
    appBarTheme: base.appBarTheme.copyWith(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      color: kPink,
      textTheme: base.primaryTextTheme.copyWith(
        title: GoogleFonts.roboto(
            fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPink,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
