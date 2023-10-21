class RecipientRegisterModel {
  bool? status;
  String? message;
  Data? data;
  String? userType;
  String? token;

  RecipientRegisterModel(
      {this.status, this.message, this.data, this.userType, this.token});

  RecipientRegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? gender;
  String? birthDate;
  String? name;
  String? contactDetails;
  String? bloodType;
  Null? medicalHistory;
  int? otp;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.gender,
      this.birthDate,
      this.name,
      this.contactDetails,
      this.bloodType,
      this.medicalHistory,
      this.otp,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    birthDate = json['birthDate'];
    name = json['name'];
    contactDetails = json['contact_details'];
    bloodType = json['blood_type'];
    medicalHistory = json['medical_history'];
    otp = json['otp'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['name'] = this.name;
    data['contact_details'] = this.contactDetails;
    data['blood_type'] = this.bloodType;
    data['medical_history'] = this.medicalHistory;
    data['otp'] = this.otp;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
