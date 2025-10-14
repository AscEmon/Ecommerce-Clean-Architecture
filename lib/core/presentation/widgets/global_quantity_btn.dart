import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GlobalQuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GlobalQuantityBtn({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary.color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 16),
        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      ),
    );
  }
}
