class EndPoints {
  // static const baseUrl = "http://127.0.0.1:8000/api/";
  static const baseUrl = "https://b1f4-197-43-54-233.ngrok.io/api/";

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
