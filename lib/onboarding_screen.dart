import 'package:first_flutter/common/colors.dart';
import 'package:first_flutter/common/primary_button.dart';
import 'package:first_flutter/signin_screen.dart';
import 'package:flutter/material.dart';

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
      title: 'Trade anytime anywhere',
      image: 'assets/images/onboarding1.png',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
    ),
    OnboardingContent(
      title: 'Save and invest at the same time',
      image: 'assets/images/onboarding2.png',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
    ),
    OnboardingContent(
      title: 'Transact fast and easy',
      image: 'assets/images/onboarding3.png',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
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
                      (index) => Container(
                        width: currentIndex == index ? 12.24 : 10,
                        height: currentIndex == index ? 12.24 : 10,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? AppColors.grey
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        }
                      },
                      buttonText: "Next",
                      width: 180,
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
