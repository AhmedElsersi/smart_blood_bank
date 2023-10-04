class LoginModel {
  int? userId;
  String? accessToken;
  String? refreshToken;
  String? username;
  String? userPhoto;

  LoginModel(
      {this.userId,
      this.accessToken,
      this.refreshToken,
      this.username,
      this.userPhoto});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    username = json['username'];
    userPhoto = json['userPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['username'] = username;
    data['userPhoto'] = userPhoto;
    return data;
  }
}
