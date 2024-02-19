import 'dart:async';
import '../../data/model/login_user_model.dart';
import '../../data/model/user_model.dart';
import '../../domain/repositories/sign_up_user_repository.dart';

abstract class AuthenticationService {
  Future<UserModel> getCurrentUser();

  Future<LoginUserModel> signInWithPhoneNumberAndPassword(
      String email);

  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<UserModel> getCurrentUser() async {
    SignUserRepository signUserRepository =  SignUserRepository();
    UserModel user = await signUserRepository.getCurrentUser();
    List users = user.data;

    for(int i = 0; i < users.length; i++){
      if(user.data[i].email == ){
        await signUserRepository.saveUserInLocalStorage(user);
        return user;
      }
    }

    return null; // return null for now
  }

  @override
  Future<LoginUserModel> signInWithPhoneNumberAndPassword(
      String email) async {
    SignUserRepository signUserRepository = SignUserRepository();

    await signUserRepository.firstLogin(email);
    return LoginUserModel(email: email);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}
