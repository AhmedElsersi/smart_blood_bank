import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masnaay/src/constants/cache_keys.dart';
import 'package:masnaay/src/constants/const_methods.dart';
import 'package:masnaay/src/constants/end_points.dart';
import 'package:masnaay/src/services/cache_helper.dart';
import 'package:masnaay/src/services/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  int userTypeId = 0;
  Future verifyOTP({
    required String otp,
  }) async {
    emit(VerifyOTPLoading());
    try {
      await DioHelper.postData(url: EndPoints.epVerifyOtp, query: {
        "Code": otp,
      }).then((value) {
        logSuccess('verifyOtp Response : ${value.data}');
        logSuccess('verifyOtp Response : ${value.headers}');
        emit(VerifyOTPSuccess());
      });
    } catch (error) {
      emit(VerifyOTPFail());
      logError(error.toString());
    }
  }

  Future register({
    required String phone,
    required String name,
    required String bloodType,
  }) async {
    emit(RegisterLoading());
    try {
      await DioHelper.postData(url: EndPoints.epRegister, body: {
        // "u_Id": userId,
        "phone": phone,
        "name": name,
        "bloodType": bloodType,
      }).then((value) {
        logSuccess('register Response : ${value.data}');

        emit(RegisterSuccess());
      });
    } catch (error) {
      emit(RegisterFailure());
      logError(error.toString());
    }
  }

  Future login({
    required List<String> phone,
  }) async {
    emit(LoginLoading());
    try {
      await DioHelper.postData(url: EndPoints.epLogin, body: {
        "phone": '${phone[0]}${phone[1]}',
      }).then((value) {
        logSuccess('login Response : ${value.data}');
        emit(LoginSuccess());
      });
    } catch (error) {
      emit(LoginFailure());
      logError(error.toString());
    }
  }

  Future logout() async {
    emit(LoginLoading());
    try {
      await DioHelper.postData(url: EndPoints.epLogout).then((value) {
        logSuccess('logout Response : ${value.data}');
        logSuccess('logout Response : ${value.headers}');
        CacheHelper.removeData(key: CacheKeys.ckApiToken);
        emit(LogoutLoading());
      });
    } catch (error) {
      emit(LogoutSuccess());
      logError(error.toString());
    }
  }

  Future getProfile() async {
    emit(GetProfileLoading());
    try {
      await DioHelper.getData(url: EndPoints.epGetProfile).then((value) {
        logSuccess('GetProfile Response : ${value.data}');
        logSuccess('GetProfile Response : ${value.headers}');
        emit(GetProfileSuccess());
      });
    } catch (error) {
      emit(GetProfileFailure());
      logError(error.toString());
    }
  }
}
