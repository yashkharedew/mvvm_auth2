import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/get_user_repository.dart';

class GetUserViewModel with ChangeNotifier {
  final _getUserRepo = GetUserRepository();

  Future<dynamic> getUserDataApi() async {
    return _getUserRepo.fetchUserDataService();
  }
}
