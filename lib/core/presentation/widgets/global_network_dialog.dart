import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '/core/presentation/widgets/global_button.dart';
import '/core/presentation/widgets/global_text.dart';

class GlobalNetworkDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const GlobalNetworkDialog({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Icon(Icons.wifi_off, color: AppColors.error.color),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.error.color),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const GlobalText(
              str: 'No Internet Connection',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const GlobalText(
              str: 'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            GlobalButton(
              btnHeight: 52.h,
              onPressed: onRetry,
              buttonText: 'Try Again',
            ),
          ],
        ),
      ),
    );
  }
}
