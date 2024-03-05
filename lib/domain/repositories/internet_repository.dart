import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionRepository {

  @override
  Future<dynamic> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      return true;
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      return false;
      print(InternetConnectionChecker().checkTimeout);
    }
  }
}