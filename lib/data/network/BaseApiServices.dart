import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_auth2/model/user_model.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);

  // Firebase Authentication SignIn Service
  void signInAuth(email, password);
  // Firebase Authentication SignUp service
  void signUpAuth(email, password, username);

  // Google Authentication Service Auth
  Future<dynamic> googleAuth();

  // add user data
  void addUserData();

  // get user data
  // Fetch data from firestore database
  Future<dynamic> fetchUserData();
}
