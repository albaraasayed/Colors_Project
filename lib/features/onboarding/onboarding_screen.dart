import 'package:first_flutter/common/colors.dart';
import 'package:first_flutter/common/primary_button.dart';
import 'package:first_flutter/features/auth/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import '../../core/cache/cache_helper.dart';

class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  List<OnboardingContent> contents = [
    OnboardingContent(
      title: 'Discover Beautiful Palettes',
      image: 'assets/images/onboarding1.png',
      description:
          'Explore AI-generated color palettes with a single tap. Endless inspiration at your fingertips.',
    ),
    OnboardingContent(
      title: 'Save Your Favorites',
      image: 'assets/images/onboarding2.png',
      description:
          'Found a shade you love? Heart it and save it to your personal favorites collection.',
    ),
    OnboardingContent(
      title: 'Your Colors, Your Style',
      image: 'assets/images/onboarding3.png',
      description:
          'Access your saved palette anytime. Create with confidence using colors tailored to you.',
    ),
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await CacheHelper.markOnboardingSeen();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const Spacer(flex: 2),
                          Image.asset(contents[i].image, height: 300),
                          const Spacer(flex: 1),
                          Text(
                            contents[i].title,
                            style: TextStyle(
                              fontSize: 28,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            contents[i].description,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: currentIndex == index ? 24 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? AppColors.primary
                              : const Color(0xFF252E35),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                    child: PrimaryButton(
                      onPressed: () {
                        if (currentIndex < contents.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _finishOnboarding();
                        }
                      },
                      buttonText: currentIndex < contents.length - 1
                          ? "Next"
                          : "Get Started",
                      width: 200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
