class LoginUserModel {

  final String email;

  LoginUserModel({required this.email});


  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
    email: json['email']
  );

  Map<String, dynamic> toJson() => {
    'email': email
  };
}