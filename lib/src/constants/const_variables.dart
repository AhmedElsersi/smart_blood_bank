import 'package:smart_blood_bank/src/services/cache_helper.dart';

import 'cache_keys.dart';

bool isGuest =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckIsGuest);
bool isUser =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckApiToken) != null;