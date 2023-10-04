import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/enums.dart';
import 'package:smart_blood_bank/src/models/services_model.dart';

void logError(String msg) => debugPrint(
      '\x1B[31m$msg\x1B[0m',
    );

void logSuccess(String msg) => debugPrint(
      '\x1B[32m$msg\x1B[0m',
    );

void logWarning(String msg) => debugPrint(
      '\x1B[33m$msg\x1B[0m',
    );

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  Future<void> toToastError() async {
    try {
      final message = isEmpty ? "error" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.error);
    } catch (e) {
      logError("toToastError error $e");
    }
  }

  Future<void> toToastSuccess() async {
    try {
      final message = isEmpty ? "success" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.success);
    } catch (e) {
      logError("toToastSuccess error: $e");
    }
  }

  Future<void> toToastWarning() async {
    try {
      final message = isEmpty ? "warning" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.warning);
    } catch (e) {
      logError("toToastWarning error: $e");
    }
  }
}

showToast(String text, ToastState state) async {
  await Fluttertoast.cancel();
  final backgroundColor = state == ToastState.success
      ? AppColors.green
      : state == ToastState.error
          ? AppColors.red
          : AppColors.yellow;
  final textColor = state == ToastState.success
      ? AppColors.white
      : state == ToastState.error
          ? AppColors.white
          : AppColors.black;
  Fluttertoast.showToast(
    msg: text,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}

String formatDateString(String dateString, String dateFormat) {
  // Create a DateTime object from the string
  DateTime date = DateTime.parse(dateString);
  // Format the date using DateFormat
  String formattedDate = DateFormat(dateFormat).format(date);
  logSuccess(formattedDate);
  return formattedDate;
}

String cateName(int catId) {
  switch (catId) {
    case 1:
      return 'Renting Machine';
    case 2:
      return 'Industrial Scrap';
    case 3:
      return 'Services / Jobs';
    case 4:
      return 'Investment Offers';
    case 5:
      return 'Products';
    default:
      return ' ';
  }
}

List<ServicesModel> cateList(int catId, BuildContext context) {
  switch (catId) {
    case 1:
      return LayoutCubit.get(context).machines;
    case 2:
      return LayoutCubit.get(context).materials;
    case 3:
      return LayoutCubit.get(context).servicesJobs;
    case 4:
      return LayoutCubit.get(context).invOffers;
    case 5:
      return LayoutCubit.get(context).products;
    default:
      return [];
  }
  ;
}