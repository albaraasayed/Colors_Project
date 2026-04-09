import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const SvgIconButton({
    super.key,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.tealAccent, BlendMode.srcIn),
        ),
      ),
    );
  }
}