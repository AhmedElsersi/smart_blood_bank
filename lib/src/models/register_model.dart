class RegisterModel {
  Result? result;
  int? id;
  String? exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  String? asyncState;
  bool? isFaulted;

  RegisterModel(
      {this.result,
      this.id,
      this.exception,
      this.status,
      this.isCanceled,
      this.isCompleted,
      this.isCompletedSuccessfully,
      this.creationOptions,
      this.asyncState,
      this.isFaulted});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['id'] = id;
    data['exception'] = exception;
    data['status'] = status;
    data['isCanceled'] = isCanceled;
    data['isCompleted'] = isCompleted;
    data['isCompletedSuccessfully'] = isCompletedSuccessfully;
    data['creationOptions'] = creationOptions;
    data['asyncState'] = asyncState;
    data['isFaulted'] = isFaulted;
    return data;
  }
}

class Result {
  int? userId;
  String? accessToken;
  String? refreshToken;
  String? username;
  String? userPhoto;

  Result(
      {this.userId,
      this.accessToken,
      this.refreshToken,
      this.username,
      this.userPhoto});

  Result.fromJson(Map<String, dynamic> json) {
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
