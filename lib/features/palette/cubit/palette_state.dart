import 'package:flutter/material.dart';

abstract class PaletteState {}

class PaletteInitial extends PaletteState {}

class PaletteLoading extends PaletteState {}

class PaletteSuccess extends PaletteState {
  final List<Color> colors;

  PaletteSuccess(this.colors);
}

class PaletteError extends PaletteState {
  final String message;

  PaletteError(this.message);
}
