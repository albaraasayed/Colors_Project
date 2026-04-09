import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/Network/ApiConstants.dart';
import '../../core/Network/DioHelper.dart';
import '../../data/Models/PaletteModel.dart';

class RemoteDataSource {
  Future<PaletteModel> fetchRandomPalette() async {
    try {
      final response = await DioHelper.dio.post(
        ApiConstants.apiEndpoint,
        data: jsonEncode({"model": "default"}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.plain,
        ),
      );

      final Map<String, dynamic> decoded = jsonDecode(response.data as String);
      return PaletteModel.fromJson(decoded);
    } catch (e, stackTrace) {
      print("RemoteDataSource Error: $e");
      print("StackTrace: $stackTrace");
      rethrow;
    }
  }
}
