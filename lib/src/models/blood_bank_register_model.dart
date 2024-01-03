class BloodBankRegisterModel {
  bool? status;
  String? message;
  Data? data;
  String? userType;
  String? token;

  BloodBankRegisterModel(
      {this.status, this.message, this.data, this.userType, this.token});

  BloodBankRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    userType = json['userType'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['userType'] = this.userType;
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? about;
  String? name;
  String? contactDetails;
  String? bloodTypes;
  String? location;
  String? otp;
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.about,
      this.name,
      this.contactDetails,
      this.bloodTypes,
      this.location,
      this.otp,
      this.image,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    name = json['name'];
    contactDetails = json['contact_details'];
    bloodTypes = json['blood_types'];
    location = json['location'];
    otp = json['otp'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['name'] = this.name;
    data['contact_details'] = this.contactDetails;
    data['blood_types'] = this.bloodTypes;
    data['location'] = this.location;
    data['otp'] = this.otp;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
