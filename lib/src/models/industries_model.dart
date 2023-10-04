class IndustriesModel {
  int? industryId;
  String? industryName;

  IndustriesModel({this.industryId, this.industryName});

  IndustriesModel.fromJson(Map<String, dynamic> json) {
    industryId = json['i_Id'];
    industryName = json['i_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['i_Id'] = industryId;
    data['i_Name'] = industryName;
    return data;
  }
}
