import 'package:hive_flutter/hive_flutter.dart';
import '../../data/Models/user_model.dart';
import '../../data/Models/favorite_color_model.dart';

class HiveHelper {
  static const String usersBoxName = 'usersBox';
  static const String favoritesBoxName = 'favoritesBox';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(FavoriteColorModelAdapter());

    await Hive.openBox<UserModel>(usersBoxName);
    await Hive.openBox<FavoriteColorModel>(favoritesBoxName);
  }

  static Box<UserModel> get usersBox => Hive.box<UserModel>(usersBoxName);
  static Box<FavoriteColorModel> get favoritesBox =>
      Hive.box<FavoriteColorModel>(favoritesBoxName);
}
