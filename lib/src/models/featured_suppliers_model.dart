class FeaturedSuppliersModel {
  int? uId;
  String? uMobile;
  String? uName;
  String? uEmail;
  String? uAbout;
  int? uTypeId;
  List<int>? industryIds;
  List<int>? interestIds;
  String? uContacts;
  String? uAddress;
  num? uLat;
  num? uLong;
  String? uImg;
  List<String>? uProfilePicture;
  num? uRating;
  int? uRatingCount;
  String? uMembership;

  FeaturedSuppliersModel(
      {this.uId,
      this.uMobile,
      this.uName,
      this.uEmail,
      this.uAbout,
      this.uTypeId,
      this.industryIds,
      this.interestIds,
      this.uContacts,
      this.uAddress,
      this.uLat,
      this.uLong,
      this.uImg,
      this.uProfilePicture,
      this.uRating,
      this.uRatingCount,
      this.uMembership});

  FeaturedSuppliersModel.fromJson(Map<String, dynamic> json) {
    uId = json['u_Id'];
    uMobile = json['u_Mobile'];
    uName = json['u_Name'];
    uEmail = json['u_Email'];
    uAbout = json['u_About'];
    uTypeId = json['u_TypeId'];
    industryIds = json['industryIds'];
    interestIds = json['interestIds'];
    uContacts = json['u_Contacts'];
    uAddress = json['u_Address'];
    uLat = json['u_Lat'];
    uLong = json['u_Long'];
    uImg = json['u_Img'];
    uProfilePicture = json['u_ProfilePicture'];
    uRating = json['u_Rating'];
    uRatingCount = json['u_RatingCount'];
    uMembership = json['u_Membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['u_Id'] = uId;
    data['u_Mobile'] = uMobile;
    data['u_Name'] = uName;
    data['u_Email'] = uEmail;
    data['u_About'] = uAbout;
    data['u_TypeId'] = uTypeId;
    data['industryIds'] = industryIds;
    data['interestIds'] = interestIds;
    data['u_Contacts'] = uContacts;
    data['u_Address'] = uAddress;
    data['u_Lat'] = uLat;
    data['u_Long'] = uLong;
    data['u_Img'] = uImg;
    data['u_ProfilePicture'] = uProfilePicture;
    data['u_Rating'] = uRating;
    data['u_RatingCount'] = uRatingCount;
    data['u_Membership'] = uMembership;
    return data;
  }
}
