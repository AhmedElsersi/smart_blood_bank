import 'package:flutter/material.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';

class Dot extends StatelessWidget {
  const Dot(
      {Key? key,
      required this.isActive,
      this.height,
      this.width,
      this.activeColor,
      this.color})
      : super(key: key);
  final bool isActive;
  final double? height;
  final double? width;
  final Color? activeColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 10),
        height: height ?? (isActive ? 19 : 17),
        width: width ?? (isActive ? 29 : 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            shape: BoxShape.rectangle,
            color: isActive
                ? (activeColor ?? AppColors.green)
                : (color ?? AppColors.gradientLight)),
      ),
    );
  }
}
