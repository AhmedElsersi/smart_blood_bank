import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';

import '../../services/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  String phoneNum = '';
  int userId = 0;

  Future verifyPhone({
    required List<String> phone,
  }) async {
    emit(VerifyPhoneLoading());
    try {
      await DioHelper.postDataWithoutParameters(
        url: EndPoints.epVerifyPhone,
        body: '"${phone[0]}${phone[1]}"',
      ).then((value) {
        logSuccess('verifyPhone Response : ${value.data}');

        emit(VerifyPhoneSuccess());
      });
    } catch (error) {
      logError(error.toString());
      emit(VerifyPhoneFail());
    }
  }

  Future sendOtp() async {
    emit(SendOtpLoading());
    try {
      await DioHelper.postData(
        url: EndPoints.epSendOtp,
        body: {
          "u_Mobile": phoneNum,
        },
      ).then((value) {
        logSuccess('SendOtp Response : ${value.headers}');
        emit(SendOtpSuccess());
      });
    } catch (error) {
      emit(SendOtpFail());
      logError(error.toString());
    }
  }
}
