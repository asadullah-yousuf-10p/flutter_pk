import 'package:flutter/material.dart';

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

const Color kBlue = Color(0xFF54A8DB);
const Color kPink = Color(0xFFD72E89);
final theme = _buildTheme();

ThemeData _buildTheme() {
  var base = ThemeData.light();
  print('font size of theme: ${base.primaryTextTheme.title.fontSize}');

  return base.copyWith(
    primaryColor: kBlue,
    accentColor: kPink,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      iconTheme: base.iconTheme.copyWith(color: Colors.black),
      color: Colors.white,
      textTheme: base.primaryTextTheme
          .copyWith(
              title: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ))
          .apply(bodyColor: Colors.black),
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPink,
      colorScheme: ColorScheme.dark(),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
