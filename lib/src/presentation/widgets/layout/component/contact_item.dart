import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class ContactItem extends StatelessWidget {
  final String label;
  final String icon;
  final bool rotate;
  final VoidCallback onTap;
  const ContactItem({
    Key? key,
    required this.label,
    this.rotate = false,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            scale: 3.5,
          ),
          SizedBox(
            height: 1.h,
          ),
          DefaultText(
            text: label,
            textColor: AppColors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
