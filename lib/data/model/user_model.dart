/// data : [{"id":5,"email":"","isAdmin":null,"creationDate":"2024-02-18T08:12:20.9129317"},{"id":3,"email":"alishakoori89@gmail.com","isAdmin":true,"creationDate":"2024-02-17T15:52:40.2064261"},{"id":2,"email":"pedrampourhakim1999@gmail.com","isAdmin":true,"creationDate":"2024-01-22T00:00:00"}]
/// success : true
/// message : "موفقیت آمیز"
/// lastPage : 1

class UserModel {
  UserModel({
      List<Data> data, 
      bool success, 
      String message, 
      num lastPage,}){
    _data = data;
    _success = success;
    _message = message;
    _lastPage = lastPage;
}

  UserModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _lastPage = json['lastPage'];
  }
  List<Data> _data;
  bool _success;
  String _message;
  num _lastPage;
UserModel copyWith({  List<Data> data,
  bool success,
  String message,
  num lastPage,
}) => UserModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  lastPage: lastPage ?? _lastPage,
);
  List<Data> get data => _data;
  bool get success => _success;
  String get message => _message;
  num get lastPage => _lastPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['lastPage'] = _lastPage;
    return map;
  }

}

/// id : 5
/// email : ""
/// isAdmin : null
/// creationDate : "2024-02-18T08:12:20.9129317"

class Data {
  Data({
      num id, 
      String email, 
      dynamic isAdmin, 
      String creationDate,}){
    _id = id;
    _email = email;
    _isAdmin = isAdmin;
    _creationDate = creationDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _isAdmin = json['isAdmin'];
    _creationDate = json['creationDate'];
  }
  num _id;
  String _email;
  dynamic _isAdmin;
  String _creationDate;
Data copyWith({  num id,
  String email,
  dynamic isAdmin,
  String creationDate,
}) => Data(  id: id ?? _id,
  email: email ?? _email,
  isAdmin: isAdmin ?? _isAdmin,
  creationDate: creationDate ?? _creationDate,
);
  num get id => _id;
  String get email => _email;
  dynamic get isAdmin => _isAdmin;
  String get creationDate => _creationDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['isAdmin'] = _isAdmin;
    map['creationDate'] = _creationDate;
    return map;
  }

}