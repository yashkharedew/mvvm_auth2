import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_auth2/repository/auth_repository.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  Future signUpApi(email, password, name, BuildContext context) async {
    // _authRepo.signUpAuthService(email, password, username).then((value) {
    //   if (kDebugMode) {
    //     print(value.toString());
    //   }
    // }).onError((error, stackTrace) {
    //   if (kDebugMode) {
    //     print(error.toString());
    //   }
    // });
    await _authRepo.signUpAuthService(email, password, name);
  }

  Future signInApi(email, password, BuildContext context) async {
    await _authRepo.signInAuthService(email, password);
  }

  Future googleAuthApi() async {
    await _authRepo.googleAuthService();
  }

  void passwordSignOutApi() {
    _authRepo.passwordSignOut();
  }
  // void getUserAuthDataApi(user) {
  //   _authRepo.getUserAuthDataService(user);
  // }
}
