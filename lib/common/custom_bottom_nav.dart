import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _NavBarItem(icon: Icons.home_rounded, label: 'Home', isSelected: true),
          _NavBarItem(icon: Icons.shopping_bag_outlined, label: 'Markets'),
          _NavBarItem(icon: Icons.swap_horiz_rounded, label: 'Trades'),
          _NavBarItem(icon: Icons.receipt_long_rounded, label: 'Activity'),
          _NavBarItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallets'),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.tealAccent : Colors.white54,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.tealAccent : Colors.white54,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}