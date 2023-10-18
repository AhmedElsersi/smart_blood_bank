class RegisterModel {
  bool? status;
  String? message;
  Data? data;
  String? userType;
  String? token;

  RegisterModel(
      {this.status, this.message, this.data, this.userType, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    userType = json['userType'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['userType'] = userType;
    data['token'] = token;
    return data;
  }
}

class Data {
  String? about;
  String? name;
  String? contactDetails;
  String? bloodTypes;
  String? location;
  int? otp;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about'] = about;
    data['name'] = name;
    data['contact_details'] = contactDetails;
    data['blood_types'] = bloodTypes;
    data['location'] = location;
    data['otp'] = otp;
    data['image'] = image;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
