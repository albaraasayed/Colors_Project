import 'package:flutter/material.dart';

class PaletteModel {
  final List<Color> colors;

  PaletteModel({required this.colors});

  factory PaletteModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> result = json['result'];

    List<Color> parsedColors = result.map((rgbArray) {
      return Color.fromRGBO(rgbArray[0], rgbArray[1], rgbArray[2], 1.0);
    }).toList();

    return PaletteModel(colors: parsedColors);
  }
}

// local login (hive or SQFLite)
// on boarding + isLogged in + logout (shared preferences)
// favorite screen (Adding colors to favorite screen)
// cubit (Colors Screen -Home Screen-)
