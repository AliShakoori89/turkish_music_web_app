class UserModel {
  Data? data;
  bool? success;
  String? message;
  int? lastPage;

  UserModel({this.data, this.success, this.message, this.lastPage});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    data['lastPage'] = lastPage;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  Null? isAdmin;
  String? creationDate;

  Data({this.id, this.email, this.isAdmin, this.creationDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['isAdmin'] = isAdmin;
    data['creationDate'] = creationDate;
    return data;
  }
}
