class LoginModel {
  bool? data;
  bool? success;
  String? message;
  int? lastPage;

  LoginModel({this.data, this.success, this.message, this.lastPage});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
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
