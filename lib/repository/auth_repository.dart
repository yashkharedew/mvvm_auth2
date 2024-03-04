import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_auth2/data/app_exception.dart';
import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class AuthRepository {
  final BaseApiServices _authService = NetworkApiServices();

  Future signUpAuthService(email, password, name) async {
    final response = await _authService.signUpAuth(email, password, name);
  }

  Future signInAuthService(email, password) async {
    final response = await _authService.signInAuth(email, password);
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
