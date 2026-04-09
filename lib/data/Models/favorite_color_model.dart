import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class FavoriteColorModel extends HiveObject {
  @HiveField(0)
  final int colorValue;

  @HiveField(1)
  final String hexCode;

  @HiveField(2)
  final String userEmail;

  FavoriteColorModel({
    required this.colorValue,
    required this.hexCode,
    required this.userEmail,
  });
}

class FavoriteColorModelAdapter extends TypeAdapter<FavoriteColorModel> {
  @override
  final int typeId = 1;

  @override
  FavoriteColorModel read(BinaryReader reader) {
    return FavoriteColorModel(
      colorValue: reader.readInt(),
      hexCode: reader.readString(),
      userEmail: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteColorModel obj) {
    writer.writeInt(obj.colorValue);
    writer.writeString(obj.hexCode);
    writer.writeString(obj.userEmail);
  }
}
