import 'package:flutter/material.dart';
import '../Models/favorite_color_model.dart';
import '../../core/cache/hive_helper.dart';

class FavoritesRepo {
  Future<void> addFavorite({
    required Color color,
    required String userEmail,
  }) async {
    final argb = color.toARGB32();
    final hex = '#${argb.toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}';

    final model = FavoriteColorModel(
      colorValue: argb,
      hexCode: hex,
      userEmail: userEmail,
    );
    await HiveHelper.favoritesBox.add(model);
  }

  List<FavoriteColorModel> getFavorites(String userEmail) {
    return HiveHelper.favoritesBox.values
        .where((f) => f.userEmail.toLowerCase() == userEmail.toLowerCase())
        .toList();
  }

  Future<void> removeFavorite(dynamic key) async {
    await HiveHelper.favoritesBox.delete(key);
  }

  bool isFavorite({required Color color, required String userEmail}) {
    return HiveHelper.favoritesBox.values.any(
      (f) =>
          f.colorValue == color.toARGB32() &&
          f.userEmail.toLowerCase() == userEmail.toLowerCase(),
    );
  }
}
