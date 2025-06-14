class UserExistModel {
  String? data;
  bool? success;
  String? message;
  int? lastPage;

  UserExistModel({this.data, this.success, this.message, this.lastPage});

  factory UserExistModel.fromJson(Map<String, dynamic> json) {
    return UserExistModel(
      data: json['data'] == null ? '' : json['data'], // ممکنه null باشه یا یک رشته (token)
      success: json['success'],
      message: json['message'],
      lastPage: json['lastPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'success': success,
      'message': message,
      'lastPage': lastPage,
    };
  }
}
