class EndPoints {
  static const baseUrl = "https://backend.masnaay.com/api/";
  static const imageBaseUrl = "https://backend.masnaay.com/";

  /// auth
  static const epVerifyPhone = "Users/RegisterStep1";
  static const epSendOtp = "Users/SendOTP";
  static const epVerifyOtp = "Users/VerifyPhone";
  static const epRegister = "Users/RegisterStep2";
  static const epLogin = "Users/login";
  static const epLogout = "Users/Logout";
  static const epRefreshToken = "Users/refreshToken";

  /// user
  static const epGetProfile = "UserProfile/GetProfile";

  /// common
  static const epGetIndustries = "Industry/getIndustries";
  static const epGetInterests = "Interest/getInterests";
  static const epGetUnits = "Unit/GetUnits";

  /// home
  static const epGetAds = "Home/GetAds";
  static const epGetServices = "Home/GetHomeMachines";
  static const epGetFeaturedSuppliers = "Home/FeaturedSuppliers";
  static const epGetSearchPlaces = "Home/GetSearchPlaces";

  /// service
  static const epGetService = "Item";
}
