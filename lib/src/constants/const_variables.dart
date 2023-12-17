import 'package:smart_blood_bank/src/services/cache_helper.dart';

import 'cache_keys.dart';

String userName =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? '';

String userType =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserType) ?? '';
String userGender =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserGender) ?? '';
String userBloodType =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserBloodType) ??
        '';
String userPhone =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserPhone) ?? '';
String userAbout =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserAbout) ?? '';

String name = 'وليد';
