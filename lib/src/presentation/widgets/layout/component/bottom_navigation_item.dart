import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';

import '../../default_text.dart';

class BottomNavigationItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isActive;
  final bool rotate;
  final VoidCallback onTap;
  const BottomNavigationItem({
    Key? key,
    this.isActive = false,
    this.rotate = false,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 22,
            child: SvgPicture.asset(
              icon,
              color: isActive ? AppColors.red : const Color(0xFFC8C8C8),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          DefaultText(
            text: title,
            textColor: isActive ? AppColors.red : const Color(0xFFC8C8C8),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
