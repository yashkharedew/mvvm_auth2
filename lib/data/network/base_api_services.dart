import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_auth2/model/user_model.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);

  // Firebase Authentication SignUp service
  Future signUpAuth(email, password, name);

  // Firebase Authentication SignIn Service
  Future signInAuth(email, password);

  // Google Authentication Service Auth
  Future googleAuth();

  // signout auth features
  void passwordSignOut();

  // add user data
  void addUserData();

  // add appointmentData
  Future addDoctorCardData();

  // add bottom nav data
  Future bottomNavData();

  // add doctor card data
  // Future addAppointmentData();

  // get user data
  // Fetch data from firestore database
  Future<dynamic> fetchUserData();

  // Fetch icon data from firestore database
  Future<dynamic> getIconFromFirestore();

  // Get all doctor list
  Future<dynamic> getAllDoctorList();

  // Getting details about doctors
  Future<dynamic> getDoctorCardData();

  // Getting details about appointments of current user
  Future<dynamic> getAppointmentData();

  // getting common doctor data
  Future<dynamic> getCommonDoctorData();
}
