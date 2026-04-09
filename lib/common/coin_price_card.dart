import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinPriceCard extends StatelessWidget {
  final String price;
  final String pair;
  final String change;
  final bool isPositive;
  final String iconPath;
  final Color iconColor;

  const CoinPriceCard({
    super.key,
    required this.price,
    required this.pair,
    required this.change,
    required this.isPositive,
    required this.iconPath,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.teal : Colors.redAccent,
                ),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: iconColor,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                pair.split('/')[0],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '/${pair.split('/')[1]}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  fontSize: 10,
                  color: isPositive ? Colors.teal : Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
