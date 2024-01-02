class AskDonationModel {
  String? message;
  Data? data;

  AskDonationModel({this.message, this.data});

  AskDonationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? patientName;
  String? bloodType;
  int? quantity;
  String? bloodBankId;
  String? bloodBankLocation;
  String? time;
  String? date;
  String? hospitalId;
  String? hospitalLocation;

  Data(
      {this.id,
      this.patientName,
      this.bloodType,
      this.quantity,
      this.bloodBankId,
      this.bloodBankLocation,
      this.time,
      this.date,
      this.hospitalId,
      this.hospitalLocation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patientName'];
    bloodType = json['bloodType'];
    quantity = json['quantity'];
    bloodBankId = json['bloodBankId'];
    bloodBankLocation = json['bloodBankLocation'];
    time = json['time'];
    date = json['date'];
    hospitalId = json['HospitalId'];
    hospitalLocation = json['HospitalLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientName'] = this.patientName;
    data['bloodType'] = this.bloodType;
    data['quantity'] = this.quantity;
    data['bloodBankId'] = this.bloodBankId;
    data['bloodBankLocation'] = this.bloodBankLocation;
    data['time'] = this.time;
    data['date'] = this.date;
    data['HospitalId'] = this.hospitalId;
    data['HospitalLocation'] = this.hospitalLocation;
    return data;
  }
}
