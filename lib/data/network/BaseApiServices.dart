import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_auth2/model/user_model.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);

  // Firebase Authentication SignUp service
  Future signUpAuth(email, password, username);

  // Firebase Authentication SignIn Service
  void signInAuth(email, password);

  // Google Authentication Service Auth
  Future googleAuth();

  // signout auth features
  void passwordSignOut();

  // add user data
  void addUserData();

  // add bottom nav data
  void bottomNavData();

  // get user data
  // Fetch data from firestore database
  Future<dynamic> fetchUserData();
}
