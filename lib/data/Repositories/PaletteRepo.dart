import '../../core/DataSource/RemoteDataSource.dart';
import '../Models/PaletteModel.dart';

class PaletteRepo {
  final RemoteDataSource remoteDataSource;

  PaletteRepo(this.remoteDataSource);

  Future<PaletteModel?> getRandomPalette() async {
    try {
      final result = await remoteDataSource.fetchRandomPalette();
      return result;
    } catch (e) {
      print("Repository Error: $e");
      return null;
    }
  }
}