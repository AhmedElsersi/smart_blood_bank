class EndPoints {
  static const ngrok = "https://f76f-41-34-113-190.ngrok-free.app";
  static const baseUrl = "$ngrok/api/";

  /// auth
  static const epVerifyPhone = "verify_phone";
  static const epLogin = "verify_otp";
  static const epRegister = "register";
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
}
