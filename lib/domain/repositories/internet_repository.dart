import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionRepository {

  FutureOr<dynamic> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      return true;
    } else {
      return false;
    }
  }
}