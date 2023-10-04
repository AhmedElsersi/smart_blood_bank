import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';

class BottomNavigationItem extends StatelessWidget {
  final String icon;
  final bool isActive;
  final bool rotate;
  final VoidCallback onTap;
  const BottomNavigationItem({
    Key? key,
    this.isActive = false,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: isActive ? AppColors.black : AppColors.lightGrey,
          ),
          if (isActive)
            SizedBox(
              height: 4.h,
            ),
          if (isActive)
            CircleAvatar(
              radius: 2.h,
              backgroundColor: AppColors.black,
            ),
        ],
      ),
    );
  }
}
