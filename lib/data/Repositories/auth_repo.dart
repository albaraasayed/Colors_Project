import 'package:hive/hive.dart';
import '../Models/user_model.dart';
import '../../core/cache/hive_helper.dart';

class AuthRepo {
  Box<UserModel> get _usersBox => HiveHelper.usersBox;

  String? register({
    required String name,
    required String email,
    required String password,
  }) {
    final exists = _usersBox.values.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
    if (exists) return 'An account with this email already exists.';

    _usersBox.add(UserModel(name: name, email: email, password: password));
    return null;
  }

  UserModel? login({required String email, required String password}) {
    try {
      return _usersBox.values.firstWhere(
        (u) =>
            u.email.toLowerCase() == email.toLowerCase() &&
            u.password == password,
      );
    } catch (_) {
      return null;
    }
  }
}
