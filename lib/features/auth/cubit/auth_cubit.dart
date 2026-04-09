import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../data/Repositories/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit() : _authRepo = AuthRepo(), super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of<AuthCubit>(context);

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final error = _authRepo.register(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      emit(AuthError(error));
    } else {
      await CacheHelper.saveLoginSession(email);
      emit(AuthSuccess(email));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final user = _authRepo.login(email: email, password: password);

    if (user == null) {
      emit(AuthError('Invalid email or password. Please try again.'));
    } else {
      await CacheHelper.saveLoginSession(user.email);
      emit(AuthSuccess(user.email));
    }
  }

  Future<void> logout() async {
    await CacheHelper.clearSession();
    emit(AuthInitial());
  }
}
