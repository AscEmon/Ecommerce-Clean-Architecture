import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '/core/presentation/widgets/global_text.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isRounded;
  final double? btnHeight;
  final int roundedBorderRadius;
  final Color? btnBackgroundActiveColor;
  final double? textFontSize;

  const GlobalButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isRounded = true,
    this.btnHeight,
    this.roundedBorderRadius = 17,
    this.btnBackgroundActiveColor,
    this.textFontSize,
  });

  @override
  Widget build(BuildContext context) {
    Color btnColor = btnBackgroundActiveColor ?? AppColors.primary.color;

    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
          return RoundedRectangleBorder(
            borderRadius:
                isRounded
                    ? BorderRadius.circular(roundedBorderRadius.r)
                    : BorderRadius.zero,
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) =>
              onPressed != null ? btnColor : AppColors.grey.color,
        ),
        elevation: WidgetStateProperty.resolveWith((states) => 0.0),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: btnHeight ?? 76.h,
        child: Center(
          child: GlobalText(
            str: buttonText,
            fontWeight: FontWeight.w500,
            fontSize: textFontSize ?? 14,
          ),
        ),
      ),
    );
  }
}

