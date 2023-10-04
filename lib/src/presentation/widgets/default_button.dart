import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.onTap,
    this.buttonColor,
    required this.text,
    this.child,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.fontWeight,
    this.height,
    this.width,
    this.radius,
    this.boxShadow,
    this.margin,
    this.border,
  });

  final Function() onTap;
  final Color? buttonColor;
  final String text;
  final Widget? child;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        border: border,
        borderRadius: BorderRadius.circular(
          radius ?? 10,
        ),
      ),
      height: height ?? 6.h,
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            radius ?? 10,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: buttonColor ?? AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: child ??
                DefaultText(
                  text: text,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  textColor: textColor,
                  textAlign: textAlign,
                ),
          ),
        ),
      ),
    );
  }
}
