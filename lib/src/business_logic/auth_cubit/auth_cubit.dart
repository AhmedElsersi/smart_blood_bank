import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';
import 'package:smart_blood_bank/src/models/blood_bank_register_model.dart';
import 'package:smart_blood_bank/src/models/hospital_register_model.dart';
import 'package:smart_blood_bank/src/models/person_register_model.dart';
import 'package:smart_blood_bank/src/models/recipient_register_model.dart';
import 'package:smart_blood_bank/src/models/verify_phone_model.dart';

import '../../constants/cache_keys.dart';
import '../../constants/enums.dart';
import '../../models/register_model.dart';
import '../../services/cache_helper.dart';
import '../../services/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._auth) : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  String phoneNum = '';
  int userId = 0;
  String userType = '';
  int donationLocation = 0;
  final FirebaseAuth _auth;

  List<String>? phone;
  String? _verId;
  UserCredential? _user;
  Future verifyFirebasePhone({
    required List<String> phoneNumber,
    required Function() afterSuccess,
    required Function() afterError,
  }) async {
    try {
      phone = phoneNumber;
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.join(''),
        timeout: const Duration(minutes: 1),
        verificationCompleted: (cred) {},
        verificationFailed: (e) {
          showToast(
            'Phone Verification ${e.message}',
            ToastState.error,
          );
          debugPrint('\x1B[31m verifyPhone error message: ${e.message}\x1B[0m');
          afterError();
          if (Platform.isAndroid) {
            emit(VerifyPhoneVerifyErrorState());
          }
        },
        codeSent: (verId, resCode) {
          _verId = verId;
          afterSuccess();
        },
        codeAutoRetrievalTimeout: (verID) {
          if (_user == null) {
            showToast('Phone Verification Timeout', ToastState.error);
            debugPrint('\x1B[31m Phone Verification Timeout\x1B[0m');
            // afterError();
          }
        },
      );
    } catch (e) {
      showToast('Phone Verification Failure', ToastState.error);
      afterError();
    }
  }

  Future verifyFirebaseOTp({
    required String code,
  }) async {
    try {
      emit(VerifyingOtpLoadingState());
      final cred = PhoneAuthProvider.credential(
        verificationId: _verId!,
        smsCode: code,
      );
      _user = await _auth.signInWithCredential(cred);
      if (_user?.user != null) {
        showToast(
          'Phone Verification Success',
          ToastState.success,
        );
        emit(VerifyingOtpSuccessState());
        logSuccess('________________________');
      } else {
        showToast('Invalid OTP', ToastState.error);
        emit(VerifyingOtpFailureState());
      }
    } catch (e) {
      showToast('OTP Verification Failure', ToastState.error);
      debugPrint('\x1B[31m verifyOTp error: $e\x1B[0m');
      emit(VerifyingOtpFailureState());
    }
  }

  VerifyPhoneModel verifyPhoneModel = VerifyPhoneModel();
  Future verifyPhone() async {
    emit(VerifyPhoneLoading());
    try {
      logSuccess('verifyPhone Response : ${phone?[0]}${phone?[1]}');

      await DioHelper.postData(
        url: EndPoints.epVerifyPhone,
        body: {"phone": "${phone?[0]}${phone?[1]}"},
      ).then((value) {
        logSuccess('verifyPhone Response : ${value.data}');
        verifyPhoneModel = VerifyPhoneModel.fromJson(value.data);
        if (verifyPhoneModel.status!) {
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckApiToken, value: verifyPhoneModel.token);
        }
        emit(VerifyPhoneSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
      emit(VerifyPhoneFailure());
    } catch (error) {
      logError(error.toString());
      emit(VerifyPhoneFailure());
    }
  }

  Future login({
    required String phone,
    required String pass,
  }) async {
    emit(LoginLoading());
    try {
      logSuccess('verifyPhone Response : $phone');

      await DioHelper.postData(
        url: EndPoints.epLogin,
        body: {
          "phone": phone,
          "otp": pass,
        },
      ).then((value) {
        logWarning("${value.data}");
        CacheHelper.saveDataSharedPreference(
            key: CacheKeys.ckApiToken, value: value.data["token"]);
        emit(LoginSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
      emit(LoginFailure());
    } catch (error) {
      logError(error.toString());
      emit(LoginFailure());
    }
  }

  RegisterModel registerModel = RegisterModel();
  Future register({
    required String name,
    required String phone,
    required String pass,
    required String userType,
    String? type,
    String? bloodType,
    String? birthDate,
    String? location,
    List<String>? bloodTypes,
    String? about,
    String? image,
  }) async {
    emit(RegisterLoading());
    try {
      await DioHelper.postData(url: EndPoints.epRegister, body: {
        "name": name,
        "phone": phone,
        "otp": pass,
        "userType": userType,
        "type": type,
        "bloodType": bloodType,
        "birthDate": birthDate,
        "location": location,
        "bloodTypes": bloodTypes.toString(),
        "about": about,
        "image": image,
      }).then((value) {
        logSuccess('register Response : ${value.data}');
        if (userType == 'Donor') {
          final donnerRegisterModel = DonnerRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: donnerRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: donnerRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: donnerRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserGender,
              value: donnerRegisterModel.data?.gender ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: donnerRegisterModel.data?.bloodType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: donnerRegisterModel.data?.contactDetails ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckApiToken, value: donnerRegisterModel.token);
        } else if (userType == 'Recipient') {
          final recipientRegisterModel =
              RecipientRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: recipientRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: recipientRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: recipientRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserGender,
              value: recipientRegisterModel.data?.gender ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: recipientRegisterModel.data?.bloodType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: recipientRegisterModel.data?.contactDetails ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckApiToken, value: recipientRegisterModel.token);
        } else if (userType == 'Hospital') {
          final hospitalRegisterModel =
              HospitalRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: hospitalRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: hospitalRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: hospitalRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserAbout,
              value: hospitalRegisterModel.data?.about ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: hospitalRegisterModel.data?.bloodTypes ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: hospitalRegisterModel.data?.contactDetails ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckApiToken, value: hospitalRegisterModel.token);
        } else if (userType == 'BloodBank') {
          final bloodBankRegisterModel =
              BloodBankRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: bloodBankRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: bloodBankRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: bloodBankRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserAbout,
              value: bloodBankRegisterModel.data?.about ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: bloodBankRegisterModel.data?.bloodTypes ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: bloodBankRegisterModel.data?.contactDetails ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckApiToken, value: bloodBankRegisterModel.token);
        }
        emit(RegisterSuccess());
      });
    } on DioException catch (dioError) {
      logError('mmmm ${dioError.response}');
    } catch (error) {
      emit(RegisterFailure());
      logError(error.toString());
    }
  }

  Future getProfile() async {
    emit(GetProfileLoading());
    try {
      await DioHelper.getData(url: EndPoints.epProfile).then((value) {
        logSuccess('getProfile Response : ${value.data}');
        userType = value.data["userType"];
        if (userType == 'Donor') {
          final donnerRegisterModel = DonnerRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: donnerRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: donnerRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: donnerRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserGender,
              value: donnerRegisterModel.data?.gender ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: donnerRegisterModel.data?.bloodType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: donnerRegisterModel.data?.contactDetails ?? 'aa');
        } else if (userType == 'Recipient') {
          final recipientRegisterModel =
              RecipientRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: recipientRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: recipientRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: recipientRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserGender,
              value: recipientRegisterModel.data?.gender ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: recipientRegisterModel.data?.bloodType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: recipientRegisterModel.data?.contactDetails ?? 'aa');
        } else if (userType == 'Hospital') {
          final hospitalRegisterModel =
              HospitalRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: hospitalRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: hospitalRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: hospitalRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserAbout,
              value: hospitalRegisterModel.data?.about ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: hospitalRegisterModel.data?.bloodTypes ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: hospitalRegisterModel.data?.contactDetails ?? 'aa');
        } else if (userType == 'BloodBank') {
          final bloodBankRegisterModel =
              BloodBankRegisterModel.fromJson(value.data);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserId,
              value: bloodBankRegisterModel.data?.id ?? 0);
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserName,
              value: bloodBankRegisterModel.data?.name ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserType,
              value: bloodBankRegisterModel.userType ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserAbout,
              value: bloodBankRegisterModel.data?.about ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserBloodType,
              value: bloodBankRegisterModel.data?.bloodTypes ?? 'aa');
          CacheHelper.saveDataSharedPreference(
              key: CacheKeys.ckUserPhone,
              value: bloodBankRegisterModel.data?.contactDetails ?? 'aa');
        }
        emit(GetProfileSuccess());
      });
    } catch (error) {
      emit(GetProfileFailure());
      logError(error.toString());
    }
  }

  Future logout() async {
    emit(LogoutLoading());
    try {
      await DioHelper.postData(url: EndPoints.epLogout).then((value) {
        logSuccess('logout Response : ${value.data}');
        logSuccess('logout Response : ${value.headers}');
        CacheHelper.clearData();
        emit(LogoutSuccess());
      });
    } catch (error) {
      emit(LogoutFailure());
      logError(error.toString());
    }
  }
}
