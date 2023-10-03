import 'package:flutter/material.dart';
import 'package:masnaay/src/constants/colors.dart';
import 'package:masnaay/src/localization/app_strings_extension.dart';

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
          fontSize: fontSize ?? 15,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontFamily: fontFamily ?? (context.isAr ? 'Cairo' : 'Roboto'),
          decoration: textDecoration,
        ),
      ),
    );
  }
}
