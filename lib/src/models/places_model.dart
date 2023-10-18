class PlacesModel {
  String? message;
  List<PlaceModel>? data;

  PlacesModel({this.message, this.data});

  PlacesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PlaceModel>[];
      json['data'].forEach((v) {
        data!.add(new PlaceModel.fromJson(v));
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

class PlaceModel {
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

  PlaceModel(
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

  PlaceModel.fromJson(Map<String, dynamic> json) {
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
