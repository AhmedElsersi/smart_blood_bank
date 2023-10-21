class DonationModel {
  String? message;
  String? requestStatus;

  DonationModel({this.message, this.requestStatus});

  DonationModel.fromJson(Map<String, dynamic> json) {
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
