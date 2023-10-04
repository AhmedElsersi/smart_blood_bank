class VerifyPhoneModel {
  int? uId;
  String? uMobile;
  String? uPassword;
  String? uAccessToken;
  String? uRefreshToken;
  String? uRefreshTokenExpirationTime;
  String? uRole;
  String? uName;
  String? uEmail;
  String? uAbout;
  int? uIsOTPVerified;
  num? uTypeId;
  num? uIsAccepted;
  num? uIsBlocked;
  String? uContacts;
  String? uAddress;
  num? uLat;
  num? uLong;
  num? uIsFeatured;
  String? uImg;
  String? uCreatedAt;
  num? uIsDeleted;
  String? uLang;

  VerifyPhoneModel(
      {this.uId,
      this.uMobile,
      this.uPassword,
      this.uAccessToken,
      this.uRefreshToken,
      this.uRefreshTokenExpirationTime,
      this.uRole,
      this.uName,
      this.uEmail,
      this.uAbout,
      this.uIsOTPVerified,
      this.uTypeId,
      this.uIsAccepted,
      this.uIsBlocked,
      this.uContacts,
      this.uAddress,
      this.uLat,
      this.uLong,
      this.uIsFeatured,
      this.uImg,
      this.uCreatedAt,
      this.uIsDeleted,
      this.uLang});

  VerifyPhoneModel.fromJson(Map<String, dynamic> json) {
    uId = json['u_Id'];
    uMobile = json['u_Mobile'];
    uPassword = json['u_Password'];
    uAccessToken = json['u_AccessToken'];
    uRefreshToken = json['u_RefreshToken'];
    uRefreshTokenExpirationTime = json['u_RefreshTokenExpirationTime'];
    uRole = json['u_Role'];
    uName = json['u_Name'];
    uEmail = json['u_Email'];
    uAbout = json['u_About'];
    uIsOTPVerified = json['u_IsOTPVerified'];
    uTypeId = json['u_TypeId'];
    uIsAccepted = json['u_IsAccepted'];
    uIsBlocked = json['u_IsBlocked'];
    uContacts = json['u_Contacts'];
    uAddress = json['u_Address'];
    uLat = json['u_Lat'];
    uLong = json['u_Long'];
    uIsFeatured = json['u_IsFeatured'];
    uImg = json['u_Img'];
    uCreatedAt = json['u_CreatedAt'];
    uIsDeleted = json['u_IsDeleted'];
    uLang = json['u_Lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['u_Id'] = uId;
    data['u_Mobile'] = uMobile;
    data['u_Password'] = uPassword;
    data['u_AccessToken'] = uAccessToken;
    data['u_RefreshToken'] = uRefreshToken;
    data['u_RefreshTokenExpirationTime'] = uRefreshTokenExpirationTime;
    data['u_Role'] = uRole;
    data['u_Name'] = uName;
    data['u_Email'] = uEmail;
    data['u_About'] = uAbout;
    data['u_IsOTPVerified'] = uIsOTPVerified;
    data['u_TypeId'] = uTypeId;
    data['u_IsAccepted'] = uIsAccepted;
    data['u_IsBlocked'] = uIsBlocked;
    data['u_Contacts'] = uContacts;
    data['u_Address'] = uAddress;
    data['u_Lat'] = uLat;
    data['u_Long'] = uLong;
    data['u_IsFeatured'] = uIsFeatured;
    data['u_Img'] = uImg;
    data['u_CreatedAt'] = uCreatedAt;
    data['u_IsDeleted'] = uIsDeleted;
    data['u_Lang'] = uLang;
    return data;
  }
}
