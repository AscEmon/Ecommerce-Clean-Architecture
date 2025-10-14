import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/presentation/widgets/global_text.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator.adaptive(),
        SizedBox(width: 10.w),
        GlobalText(str: text ?? ''),
      ],
    );
  }
}

