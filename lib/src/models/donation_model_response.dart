class DonationsModel {
  String? message;
  List<Donation>? data;

  DonationsModel({this.message, this.data});

  DonationsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Donation>[];
      json['data'].forEach((v) {
        data!.add(new Donation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Donation {
  String? donationDate;
  String? donationTime;
  String? additionalInfo;
  Donor? donor;
  BloodBank? bloodBank;

  Donation(
      {this.donationDate,
      this.donationTime,
      this.additionalInfo,
      this.donor,
      this.bloodBank});

  Donation.fromJson(Map<String, dynamic> json) {
    donationDate = json['donation_date'];
    donationTime = json['donation_time'];
    additionalInfo = json['additional_info'];
    donor = json['donor'] != null ? new Donor.fromJson(json['donor']) : null;
    bloodBank = json['blood_bank'] != null
        ? new BloodBank.fromJson(json['blood_bank'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donation_date'] = this.donationDate;
    data['donation_time'] = this.donationTime;
    data['additional_info'] = this.additionalInfo;
    if (this.donor != null) {
      data['donor'] = this.donor!.toJson();
    }
    if (this.bloodBank != null) {
      data['blood_bank'] = this.bloodBank!.toJson();
    }
    return data;
  }
}

class Donor {
  int? id;
  String? name;
  String? bloodType;
  String? eligibilityStatus;
  String? contactDetails;
  String? gender;
  String? birthDate;
  int? otp;
  String? createdAt;
  String? updatedAt;

  Donor(
      {this.id,
      this.name,
      this.bloodType,
      this.eligibilityStatus,
      this.contactDetails,
      this.gender,
      this.birthDate,
      this.otp,
      this.createdAt,
      this.updatedAt});

  Donor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bloodType = json['blood_type'];
    eligibilityStatus = json['eligibility_status'];
    contactDetails = json['contact_details'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['blood_type'] = this.bloodType;
    data['eligibility_status'] = this.eligibilityStatus;
    data['contact_details'] = this.contactDetails;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['otp'] = this.otp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BloodBank {
  int? id;
  String? name;
  String? contactDetails;
  String? bloodTypes;
  String? location;
  String? about;
  String? image;
  int? otp;
  String? createdAt;
  String? updatedAt;

  BloodBank(
      {this.id,
      this.name,
      this.contactDetails,
      this.bloodTypes,
      this.location,
      this.about,
      this.image,
      this.otp,
      this.createdAt,
      this.updatedAt});

  BloodBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactDetails = json['contact_details'];
    bloodTypes = json['blood_types'];
    location = json['location'];
    about = json['about'];
    image = json['image'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_details'] = this.contactDetails;
    data['blood_types'] = this.bloodTypes;
    data['location'] = this.location;
    data['about'] = this.about;
    data['image'] = this.image;
    data['otp'] = this.otp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
