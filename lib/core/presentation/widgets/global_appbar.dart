import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/presentation/widgets/global_text.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.centerTitle,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color? themeBgColor = Theme.of(context).appBarTheme.backgroundColor;
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? themeBgColor,
      title: GlobalText(
        str: title,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

