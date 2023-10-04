import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/constants/cache_keys.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';
import 'package:smart_blood_bank/src/models/industries_model.dart';
import 'package:smart_blood_bank/src/models/interests_model.dart';
import 'package:smart_blood_bank/src/models/login_model.dart';
import 'package:smart_blood_bank/src/models/profile_model.dart';
import 'package:smart_blood_bank/src/models/register_model.dart';
import 'package:smart_blood_bank/src/services/cache_helper.dart';
import 'package:smart_blood_bank/src/services/dio_helper.dart';

import '../../models/verify_phone_model.dart';

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
        final verify = VerifyPhoneModel.fromJson(value.data);
        phoneNum = '${phone[0]}${phone[1]}';
        userId = verify.uId ?? 0;
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

  String refreshToken = '';
  String accessToken = '';
  Future verifyOTP({
    required String otp,
  }) async {
    emit(VerifyOTPLoading());
    try {
      await DioHelper.postData(url: EndPoints.epVerifyOtp, query: {
        "Mobile": phoneNum,
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

  List<IndustriesModel> industries = [];
  Future getIndustries() async {
    industries.clear();
    try {
      emit(GetIndustriesLoading());
      await DioHelper.getData(url: EndPoints.epGetIndustries).then((value) {
        logSuccess('getIndustries Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        industries =
            jsonList.map((json) => IndustriesModel.fromJson(json)).toList();
        emit(GetIndustriesSuccess());
      });
    } catch (e) {
      emit(GetIndustriesFailure());
    }
  }

  List<InterestsModel> interests = [];
  Future getInterests() async {
    interests.clear();
    try {
      emit(GetInterestsLoading());
      await DioHelper.getData(url: EndPoints.epGetInterests).then((value) {
        logSuccess('getInterests Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        interests =
            jsonList.map((json) => InterestsModel.fromJson(json)).toList();
        emit(GetInterestsSuccess());
      });
    } catch (e) {
      emit(GetInterestsFailure());
    }
  }

  int userTypeId = 0;
  Future register({
    required String password,
    required String name,
    required String email,
    required List<int> selectedIndustries,
    required List<int> selectedInterests,
  }) async {
    // logSuccess('userId $userId');
    // logSuccess('phoneNum $phoneNum');
    logSuccess('selectedIndustries $selectedIndustries');
    logSuccess('selectedIndustries $selectedInterests');
    emit(RegisterLoading());
    try {
      await DioHelper.postData(url: EndPoints.epRegister, body: {
        // "u_Id": userId,
        "u_Mobile": phoneNum,
        "u_Password": password,
        "u_Name": name,
        "u_Email": email,
        "u_TypeId": userTypeId,
        "u_IndustryIdArr": selectedIndustries,
        "u_InterestIdArr": selectedInterests
      }).then((value) {
        logSuccess('register Response : ${value.data}');
        final register = RegisterModel.fromJson(value.data);
        accessToken = register.result?.accessToken ?? '';
        refreshToken = register.result?.refreshToken ?? '';
        logSuccess('register Response : $register');
        emit(RegisterSuccess());
      });
    } catch (error) {
      emit(RegisterFailure());
      logError(error.toString());
    }
  }

  Future login({
    required String password,
    List<String>? phone,
    String? mobile,
  }) async {
    // logSuccess('userId $userId');
    // logSuccess('phoneNum $phoneNum');
    emit(LoginLoading());
    try {
      await DioHelper.postData(url: EndPoints.epLogin, body: {
        "u_Mobile": mobile ?? '${phone?[0]}${phone?[1]}',
        "u_Password": password,
        "u_Role": "",
      }).then((value) {
        logSuccess('login Response : ${value.data}');
        final login = LoginModel.fromJson(value.data);
        accessToken = login.accessToken ?? '';
        refreshToken = login.refreshToken ?? '';
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckRefreshToken, value: refreshToken);
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckApiToken, value: accessToken);
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckIsGuest, value: false);
        logSuccess('login Response : $register');
        emit(LoginSuccess());
      });
    } catch (error) {
      emit(LoginFailure());
      logError(error.toString());
    }
  }

  Future refreshesToken() async {
    emit(RefreshTokenLoading());
    try {
      await DioHelper.postData(url: EndPoints.epRefreshToken, body: {
        "refreshToken": CacheHelper.getDataFromSharedPreference(
                key: CacheKeys.ckRefreshToken) ??
            refreshToken,
      }).then((value) {
        logSuccess('refreshToken Response : ${value.data}');
        final login = LoginModel.fromJson(value.data);
        accessToken = login.accessToken ?? '';
        refreshToken = login.refreshToken ?? '';
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckRefreshToken, value: refreshToken);
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckApiToken, value: accessToken);
        emit(RefreshTokenSuccess());
      });
    } catch (error) {
      emit(RefreshTokenFailure());
      logError(error.toString());
    }
  }

  Future logout() async {
    emit(LoginLoading());
    try {
      await DioHelper.postData(url: EndPoints.epLogout, token: accessToken)
          .then((value) {
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

  ProfileModel user = ProfileModel();
  Future getProfile() async {
    emit(GetProfileLoading());
    try {
      await DioHelper.getData(url: EndPoints.epGetProfile).then((value) {
        logSuccess('GetProfile Response : ${value.data}');
        logSuccess('GetProfile Response : ${value.headers}');
        user = ProfileModel.fromJson(value.data);
        emit(GetProfileSuccess());
      });
    } catch (error) {
      emit(GetProfileFailure());
      logError(error.toString());
    }
  }
}
