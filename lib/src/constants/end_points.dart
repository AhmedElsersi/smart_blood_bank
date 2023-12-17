class EndPoints {
  // static const baseUrl = "http://127.0.0.1:8000/api/";
  static const baseUrl = "https://8e5b-156-204-216-215.ngrok.io/api/";

  /// auth
  static const epVerifyPhone = "verify_phone";
  static const epRegister = "register";
  static const epLogout = "logout";

  /// services
  static const epGetHospitals = "getHospitals";
  static epGetHospital(int id) => "getHospital/$id";
  static const epSearchHospital = "searchHospitals";
  static const epGetBloodBanks = "getBloodBanks";
  static epGetBloodBank(int id) => "getBloodBank/$id";
  static const epSearchBloodBank = "searchBloodBank";

  /// Donation
  static const epDonate = "donate";
  static const epRequestDonation = "requestDonation";
  static const epGetDonations = "getDonation";
  static epGetDonation(int id) => "getDonation/$id";
  static const epGetAskDonations = "getAskDonation";
  static epGetAskDonation(int id) => "getAskDonation/$id";
}
