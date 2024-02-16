import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/add_user_repository.dart';
import 'package:mvvm_auth2/repository/get_user_repository.dart';

class AddUserViewModel with ChangeNotifier {
  final _addUserRepo = AddUserRepository();

  void addUserApi() {
    _addUserRepo.addUserServiceRepo();
  }
}
