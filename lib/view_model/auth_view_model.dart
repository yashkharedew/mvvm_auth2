import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_auth2/repository/auth_repository.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  void signInApi(email, password, BuildContext context) async {
    _authRepo.signInAuthService(email, password);
  }

  void signUpApi(email, password, username, BuildContext context) {
    // _authRepo.signUpAuthService(email, password, username).then((value) {
    //   if (kDebugMode) {
    //     print(value.toString());
    //   }
    // }).onError((error, stackTrace) {
    //   if (kDebugMode) {
    //     print(error.toString());
    //   }
    // });
    _authRepo.signUpAuthService(email, password, username);
  }

  Future<void> googleAuthApi() async {
    _authRepo.googleAuthService();
  }

  void passwordSignOutApi() {
    _authRepo.passwordSignOut();
  }
  // void getUserAuthDataApi(user) {
  //   _authRepo.getUserAuthDataService(user);
  // }
}
