class UnitsModel {
  int? uId;
  String? uName;

  UnitsModel({this.uId, this.uName});

  UnitsModel.fromJson(Map<String, dynamic> json) {
    uId = json['u_Id'];
    uName = json['u_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_Id'] = this.uId;
    data['u_Name'] = this.uName;
    return data;
  }
}
