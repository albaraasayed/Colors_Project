import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/Repositories/PaletteRepo.dart';
import '../../../core/DataSource/RemoteDataSource.dart';
import 'palette_state.dart';

class PaletteCubit extends Cubit<PaletteState> {
  final PaletteRepo _paletteRepo;

  PaletteCubit()
    : _paletteRepo = PaletteRepo(RemoteDataSource()),
      super(PaletteInitial());

  static PaletteCubit get(BuildContext context) =>
      BlocProvider.of<PaletteCubit>(context);

  Future<void> fetchPalette() async {
    emit(PaletteLoading());
    try {
      final model = await _paletteRepo.getRandomPalette();
      if (model != null && model.colors.isNotEmpty) {
        emit(PaletteSuccess(model.colors));
      } else {
        emit(PaletteError('Failed to load the AI palette. Please try again.'));
      }
    } catch (e) {
      emit(PaletteError('Something went wrong: ${e.toString()}'));
    }
  }
}
