import 'package:flutter/material.dart';
import '../../../data/Models/favorite_color_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteColorModel> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}

class FavoriteToggled extends FavoritesState {
  final List<Color> currentPaletteColors;
  final Set<int> favoritedColorValues;

  FavoriteToggled({
    required this.currentPaletteColors,
    required this.favoritedColorValues,
  });
}
