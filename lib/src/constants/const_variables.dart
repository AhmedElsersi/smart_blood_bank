import 'package:smart_blood_bank/src/services/cache_helper.dart';

import 'cache_keys.dart';

String user =
    CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? '';
String name = 'وليد';
