import 'package:first_flutter/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common/colors.dart';
import '../../core/cache/cache_helper.dart';
import '../auth/screens/signin_screen.dart';
import '../palette/screens/home_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Widget destination;

    if (!CacheHelper.isOnboardingSeen) {
      destination = const OnboardingScreen();
    } else if (CacheHelper.isLoggedIn) {
      destination = const HomeColor();
    } else {
      destination = const SignInScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 66),
            child: Stack(
              children: [
                Image.asset('assets/images/Constelllations.png'),
                Lottie.asset('assets/animations/animation.json'),
              ],
            ),
          ),
          Image.asset('assets/images/gradient.png'),
        ],
      ),
    );
  }
}
