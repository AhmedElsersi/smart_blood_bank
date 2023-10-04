class ServicesModel {
  int? id;
  String? imLocation;
  String? name;
  String? date;
  String? industry;
  String? area;
  String? city;
  int? price;
  String? unit;
  int? isAcitve;
  int? typeId;
  String? type;

  ServicesModel(
      {this.id,
      this.imLocation,
      this.name,
      this.date,
      this.industry,
      this.area,
      this.city,
      this.price,
      this.unit,
      this.isAcitve,
      this.typeId,
      this.type});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imLocation = json['im_Location'];
    name = json['name'];
    date = json['date'];
    industry = json['industry'];
    area = json['area'];
    city = json['city'];
    price = json['price'];
    unit = json['unit'];
    isAcitve = json['is_Acitve'];
    typeId = json['typeId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['im_Location'] = imLocation;
    data['name'] = name;
    data['date'] = date;
    data['industry'] = industry;
    data['area'] = area;
    data['city'] = city;
    data['price'] = price;
    data['unit'] = unit;
    data['is_Acitve'] = isAcitve;
    data['typeId'] = typeId;
    data['type'] = type;
    return data;
  }
}
