import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/constants/colors.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    super.key,
    required this.controller,
    this.borderRadius,
    this.suffix,
    this.prefix,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.readOnly,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.textAlign,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.unfocusOnTapOutside = false,
    this.obscureText,
    this.maxLines,
    this.maxLength,
    this.width,
    this.height,
    this.hintTextColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.boxShadow,
    this.border,
    this.padding,
    this.inputFormatters,
    this.color,
    this.bottomBorder,
    this.margin,
    this.borderColor,
    this.alignVertical,
  });

  final double? borderRadius;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final TextEditingController controller;
  final Function()? onTap;
  final Function(String val)? onChanged;
  final bool? readOnly;
  final bool? enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? hintTextColor;
  final double? hintFontSize;
  final FontWeight? hintFontWeight;
  final bool unfocusOnTapOutside;
  final bool? obscureText;
  final bool? bottomBorder;
  final bool? alignVertical;
  final int? maxLines;
  final int? maxLength;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 7.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: (bottomBorder ?? false)
              ? null
              : BorderRadius.circular(
                  borderRadius ?? 10,
                ),
          border: border ??
              Border.all(
                color: borderColor ?? AppColors.textFieldBorder,
              ),
          boxShadow: boxShadow),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: textInputAction,
        textAlignVertical:
            (alignVertical ?? true) ? TextAlignVertical.center : null,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Montserrat',
        ),
        readOnly: readOnly ?? false,
        enabled: enabled,
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        onTapOutside: (e) {
          if (unfocusOnTapOutside) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor,
              fontSize: hintFontSize,
              fontWeight: hintFontWeight,
              fontFamily: 'Montserrat',
            ),
            prefixIcon: prefix,
            suffixIcon: suffix,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            isDense: true),
      ),
    );
  }
}
