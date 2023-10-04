class AdsModel {
  int? aId;
  String? aImgUrl;
  String? aUrl;
  int? aSeqId;
  int? aIsActive;
  String? aImType;

  AdsModel(
      {this.aId,
      this.aImgUrl,
      this.aUrl,
      this.aSeqId,
      this.aIsActive,
      this.aImType});

  AdsModel.fromJson(Map<String, dynamic> json) {
    aId = json['a_Id'];
    aImgUrl = json['a_ImgUrl'];
    aUrl = json['a_Url'];
    aSeqId = json['a_SeqId'];
    aIsActive = json['a_IsActive'];
    aImType = json['a_ImType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a_Id'] = this.aId;
    data['a_ImgUrl'] = this.aImgUrl;
    data['a_Url'] = this.aUrl;
    data['a_SeqId'] = this.aSeqId;
    data['a_IsActive'] = this.aIsActive;
    data['a_ImType'] = this.aImType;
    return data;
  }
}
