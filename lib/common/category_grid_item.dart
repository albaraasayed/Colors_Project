import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryGridItem extends StatelessWidget {
  final String assetPath;
  final String label;

  const CategoryGridItem({
    super.key,
    required this.assetPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          assetPath,
          width: 70,
          height: 70,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}