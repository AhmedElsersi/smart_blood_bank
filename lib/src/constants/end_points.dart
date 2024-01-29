class EndPoints {
  static const ngrok = "https://1417-197-57-17-177.ngrok-free.app";
  static const baseUrl = "$ngrok/api/";

  /// auth
  static const epVerifyPhone = "verify_phone";
  static const epLogin = "verify_otp";
  static const epRegister = "register";
  static const epProfile = "getProfile";
  static const epLogout = "logout";

  static const epGetNotifications = "notification";

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
  static const epGetDonations = "getDonations";
  static epGetDonation(int id) => "getDonations?$id";
  static const epGetAskDonations = "getRequestsOfAskingDonation";
  static const epGetAskDonation = "getRequestsOfAskingDonation";
  static const epAcceptRefuseDonation = "acceptOrCancelDonation";
  static const epAcceptRefuseAskDonation = "acceptOrCancelRequestDonation";
}
