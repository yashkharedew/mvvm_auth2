import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_auth2/data/app_exception.dart';
import 'package:mvvm_auth2/data/network/BaseApiServices.dart';
import 'package:mvvm_auth2/data/network/NetworkApiServices.dart';

class AuthRepository {
  final BaseApiServices _authService = NetworkApiServices();

  Future signUpAuthService(email, password, username) async {
    final response = await _authService.signUpAuth(email, password, username);
  }

  void signInAuthService(email, password) {
    final response = _authService.signInAuth(email, password);
  }

  Future googleAuthService() async {
    final response = await _authService.googleAuth();
    return response;
  }

  void passwordSignOut() {
    final response = _authService.passwordSignOut();
  }

  // void getUserAuthDataService(user) {
  //   final response = _authService.getUserAuthData(user);
  // }
}
