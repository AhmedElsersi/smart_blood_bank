class VerifyPhoneModel {
  bool? status;
  String? message;
  String? token;
  int? otp;

  VerifyPhoneModel({this.status, this.message, this.token, this.otp});

  VerifyPhoneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    data['otp'] = this.otp;
    return data;
  }
}
