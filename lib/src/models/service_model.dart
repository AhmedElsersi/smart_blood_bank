class ServiceModel {
  int? iId;
  String? iCreatedAt;
  int? iTypeId;
  String? iType;
  String? iName;
  String? iDesc;
  String? iDetails;
  int? iIndustryId;
  String? iIndustry;
  int? iMaterialId;
  String? iMaterial;
  int? iOwnerId;
  String? iOwner;
  String? iOwnerPhoto;
  int? iOwnerRating;
  int? iRatingCount;
  String? iOwnerMembership;
  int? iPrice;
  int? iUnitId;
  String? iUnit;
  int? iAreaId;
  String? iArea;
  int? iCityId;
  String? iCity;
  String? iAddress;
  String? iContact;
  String? iMobile;
  int? iIsActive;
  int? iIsAccepted;
  int? iIsLiked;
  String? iImages;
  List<String>? iATimes;
  List<String>? iImgURLs;

  ServiceModel(
      {this.iId,
      this.iCreatedAt,
      this.iTypeId,
      this.iType,
      this.iName,
      this.iDesc,
      this.iDetails,
      this.iIndustryId,
      this.iIndustry,
      this.iMaterialId,
      this.iMaterial,
      this.iOwnerId,
      this.iOwner,
      this.iOwnerPhoto,
      this.iOwnerRating,
      this.iRatingCount,
      this.iOwnerMembership,
      this.iPrice,
      this.iUnitId,
      this.iUnit,
      this.iAreaId,
      this.iArea,
      this.iCityId,
      this.iCity,
      this.iAddress,
      this.iContact,
      this.iMobile,
      this.iIsActive,
      this.iIsAccepted,
      this.iIsLiked,
      this.iImages,
      this.iATimes,
      this.iImgURLs});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    iId = json['i_Id'];
    iCreatedAt = json['i_CreatedAt'];
    iTypeId = json['i_TypeId'];
    iType = json['i_Type'];
    iName = json['i_Name'];
    iDesc = json['i_Desc'];
    iDetails = json['i_Details'];
    iIndustryId = json['i_IndustryId'];
    iIndustry = json['i_Industry'];
    iMaterialId = json['i_MaterialId'];
    iMaterial = json['i_Material'];
    iOwnerId = json['i_OwnerId'];
    iOwner = json['i_Owner'];
    iOwnerPhoto = json['i_OwnerPhoto'];
    iOwnerRating = json['i_OwnerRating'];
    iRatingCount = json['i_RatingCount'];
    iOwnerMembership = json['i_OwnerMembership'];
    iPrice = json['i_Price'];
    iUnitId = json['i_UnitId'];
    iUnit = json['i_Unit'];
    iAreaId = json['i_AreaId'];
    iArea = json['i_Area'];
    iCityId = json['i_CityId'];
    iCity = json['i_City'];
    iAddress = json['i_Address'];
    iContact = json['i_Contact'];
    iMobile = json['i_Mobile'];
    iIsActive = json['i_IsActive'];
    iIsAccepted = json['i_IsAccepted'];
    iIsLiked = json['i_IsLiked'];
    iImages = json['i_Images'];
    iATimes = json['i_ATimes'].cast<String>();
    iImgURLs = json['i_ImgURLs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['i_Id'] = iId;
    data['i_CreatedAt'] = iCreatedAt;
    data['i_TypeId'] = iTypeId;
    data['i_Type'] = iType;
    data['i_Name'] = iName;
    data['i_Desc'] = iDesc;
    data['i_Details'] = iDetails;
    data['i_IndustryId'] = iIndustryId;
    data['i_Industry'] = iIndustry;
    data['i_MaterialId'] = iMaterialId;
    data['i_Material'] = iMaterial;
    data['i_OwnerId'] = iOwnerId;
    data['i_Owner'] = iOwner;
    data['i_OwnerPhoto'] = iOwnerPhoto;
    data['i_OwnerRating'] = iOwnerRating;
    data['i_RatingCount'] = iRatingCount;
    data['i_OwnerMembership'] = iOwnerMembership;
    data['i_Price'] = iPrice;
    data['i_UnitId'] = iUnitId;
    data['i_Unit'] = iUnit;
    data['i_AreaId'] = iAreaId;
    data['i_Area'] = iArea;
    data['i_CityId'] = iCityId;
    data['i_City'] = iCity;
    data['i_Address'] = iAddress;
    data['i_Contact'] = iContact;
    data['i_Mobile'] = iMobile;
    data['i_IsActive'] = iIsActive;
    data['i_IsAccepted'] = iIsAccepted;
    data['i_IsLiked'] = iIsLiked;
    data['i_Images'] = iImages;
    data['i_ATimes'] = iATimes;
    data['i_ImgURLs'] = iImgURLs;
    return data;
  }
}
