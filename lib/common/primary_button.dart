import 'package:flutter/material.dart';

import 'colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final double? width;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: width ?? double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: AppColors.darkBackground,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
