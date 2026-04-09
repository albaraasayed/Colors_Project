import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/Repositories/favorites_repo.dart';
import '../../../core/cache/cache_helper.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _favoritesRepo;

  final Set<int> _favoritedColorValues = {};

  FavoritesCubit()
    : _favoritesRepo = FavoritesRepo(),
      super(FavoritesInitial());

  static FavoritesCubit get(BuildContext context) =>
      BlocProvider.of<FavoritesCubit>(context);

  String get _userEmail => CacheHelper.loggedInEmail ?? '';

  void loadFavorites() {
    final favorites = _favoritesRepo.getFavorites(_userEmail);
    _favoritedColorValues.clear();
    for (final f in favorites) {
      _favoritedColorValues.add(f.colorValue);
    }
    emit(FavoritesLoaded(favorites));
  }

  Future<void> removeFavorite({
    required dynamic hiveKey,
    required int colorValue,
  }) async {
    await _favoritesRepo.removeFavorite(hiveKey);
    _favoritedColorValues.remove(colorValue);
    loadFavorites();
  }

  void initForPalette(List<Color> paletteColors) {
    _favoritedColorValues.clear();
    for (final color in paletteColors) {
      if (_favoritesRepo.isFavorite(color: color, userEmail: _userEmail)) {
        _favoritedColorValues.add(color.toARGB32());
      }
    }
    emit(
      FavoriteToggled(
        currentPaletteColors: paletteColors,
        favoritedColorValues: Set.from(_favoritedColorValues),
      ),
    );
  }

  Future<void> toggleFavorite({
    required Color color,
    required List<Color> paletteColors,
  }) async {
    if (_favoritedColorValues.contains(color.toARGB32())) {
      final entry = _favoritesRepo
          .getFavorites(_userEmail)
          .firstWhere(
            (f) => f.colorValue == color.toARGB32(),
            orElse: () => throw Exception('Not found'),
          );
      await _favoritesRepo.removeFavorite(entry.key);
      _favoritedColorValues.remove(color.toARGB32());
    } else {
      await _favoritesRepo.addFavorite(color: color, userEmail: _userEmail);
      _favoritedColorValues.add(color.toARGB32());
    }
    emit(
      FavoriteToggled(
        currentPaletteColors: paletteColors,
        favoritedColorValues: Set.from(_favoritedColorValues),
      ),
    );
  }
}
