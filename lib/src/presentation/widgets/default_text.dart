import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.textAlign,
    this.fontSize,
    this.textDecoration,
    this.fontFamily,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.onTap,
    this.height,
  });

  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final TextDirection? textDirection;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          height: height,
          color: textColor ?? AppColors.black,
          fontSize: fontSize ?? 15.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontFamily: 'Cairo',
          decoration: textDecoration,
        ),
      ),
    );
  }
}
