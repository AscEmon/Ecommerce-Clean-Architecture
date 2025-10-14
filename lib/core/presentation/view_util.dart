import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/navigation.dart';
import '../theme/app_colors.dart';
import 'widgets/global_text.dart';

class ViewUtil {
  static snackbar(String msg, {String? btnName, void Function()? onPressed}) {
    return ScaffoldMessenger.of(Navigation.key.currentContext!).showSnackBar(
      SnackBar(
        content: GlobalText(
          str: msg,
          fontWeight: FontWeight.w500,
          color: AppColors.white.color,
        ),
        action: SnackBarAction(
          label: btnName ?? '',
          textColor:
              btnName == null ? Colors.transparent : AppColors.white.color,
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }

  // global alert dialog
  static Future alertDialog({
    Widget? title,
    required Widget content,
    List<Widget>? actions,
    Color? alertBackgroundColor,
    bool? barrierDismissible,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
  }) async {
    // flutter defined function.
    await showDialog(
      context: Navigation.key.currentContext!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        // return object of type Dialog.
        return AlertDialog(
          backgroundColor: alertBackgroundColor ?? Colors.transparent,
          contentPadding:
              contentPadding ?? EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          shape: RoundedRectangleBorder(
            borderRadius:
                borderRadius ?? BorderRadius.all(Radius.circular(8.w)),
          ),
          title: title,
          content: content,
        );
      },
    );
  }

  static bottomSheet({
    required BuildContext context,
    bool? isDismissable,
    required Widget content,
    BoxConstraints? boxConstraints,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      constraints: boxConstraints,
      isScrollControlled: true,
      context: context,
      isDismissible: isDismissable ?? true,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1a000000),
                  offset: const Offset(0, 1),
                  blurRadius: 3.r,
                  spreadRadius: 0,
                ),
              ],
              color: const Color(0xffffffff),
            ),
            child: content,
          ),
    );
  }
}

