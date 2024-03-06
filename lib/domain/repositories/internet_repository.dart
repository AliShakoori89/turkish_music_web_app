import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionRepository {

  @override
  Future<dynamic> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
      return true;

    } else {
      print('No internet :( Reason:');
      print(InternetConnectionChecker().checkTimeout);
      return false;

    }
  }
}