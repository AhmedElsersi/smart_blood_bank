class EndPoints {
  // static const baseUrl = "http://127.0.0.1:8000/api/";
  static const baseUrl = "https://3df1-102-44-251-10.ngrok-free.app/api/";

  /// auth
  static const epVerifyPhone = "verify_phone";
  static const epRegister = "register";
  static const epLogout = "logout";

  /// services
  static const epGetHospitals = "getHospitals";
  static const epGetHospital = "getHospital";
  static const epSearchHospital = "searchHospitals";
  static const epGetBloodBanks = "getBloodBanks";
  static const epGetBloodBank = "getBloodBank";
  static const epSearchBloodBank = "searchBloodBank";
}
