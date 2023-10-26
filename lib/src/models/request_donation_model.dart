class RequestDonationModel {
  String? message;
  String? requestStatus;

  RequestDonationModel({this.message, this.requestStatus});

  RequestDonationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    requestStatus = json['requestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['requestStatus'] = this.requestStatus;
    return data;
  }
}
