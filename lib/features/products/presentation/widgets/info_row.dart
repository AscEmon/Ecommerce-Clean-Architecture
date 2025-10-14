import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/global_text.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: GlobalText(
            str: '$label:',
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Expanded(child: GlobalText(str: value, fontSize: 13)),
      ],
    );
  }
}
