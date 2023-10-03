import 'package:flutter/material.dart';
import 'package:masnaay/src/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? AppColors.primary,
    );
  }
}
