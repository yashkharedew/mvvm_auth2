import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:mvvm_auth2/data/network/NetworkApiServices.dart';

import '../data/network/BaseApiServices.dart';

class GetUserRepository {
  final BaseApiServices _getUserDataService = NetworkApiServices();

  Future<dynamic> fetchUserDataService() async {
    final response = await _getUserDataService.fetchUserData();
    return response;
  }

  // code here
}
