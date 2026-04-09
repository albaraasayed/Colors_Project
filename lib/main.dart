import 'package:first_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:first_flutter/features/favorites/cubit/favorites_cubit.dart';
import 'package:first_flutter/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/Network/DioHelper.dart';
import 'core/cache/cache_helper.dart';
import 'core/cache/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all services before app starts
  await Future.wait([
    CacheHelper.init(),
    HiveHelper.init(),
  ]);
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coloring Studio',
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: const ColorScheme.dark(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
