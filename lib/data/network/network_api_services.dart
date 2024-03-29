import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_auth2/model/bottom_nav_model.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
import 'package:mvvm_auth2/model/user_model.dart';

import '../app_exception.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson;
  User? users = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future getGetApiResponse(String url) async {
    try {
      // TODO: implement getGetApiResponse
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw BadDataException('No internet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) {
    // TODO: implement getPostApiResponse
    throw UnimplementedError();
  }

  @override
  Future signUpAuth(email, password, name) async {
    final UserCredential credential;
    try {
      credential = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));
      users = credential.user;
      print(users!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw BadDataException(e.toString());
      } else if (e.code == 'email-already-in-use') {
        throw UnauthorizedException(e.toString());
      }
    }
  }

  @override
  Future signInAuth(email, password) async {
    final credential;
    try {
      credential = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
      users = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw BadDataException(e.toString());
      } else if (e.code == 'email-already-in-use') {
        throw UnauthorizedException(e.toString());
      }
    }
  }

  @override
  Future googleAuth() async {
    users = FirebaseAuth.instance.currentUser;
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        users = userCredential.user;
        print("Google auth---${users!.email}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
  }

  @override
  void passwordSignOut() {
    FirebaseAuth.instance.signOut();
  }

  // @override
  // Future<dynamic> getUserAuthData(User user) async {
  //   // TODO: implement getUserAuthData
  //   users = FirebaseAuth.instance.currentUser;
  //   if (users != null) {
  //     print("User Display Name: ${user.displayName}");
  //     print("User Email: ${user.email}");
  //     print("User Photo URL: ${user.photoURL}");
  //     // Add more fields as needed
  //   } else {
  //     throw BadDataException('user not found');
  //   }
  //   return users;
  // }

  @override
  void addUserData() {
    // db.collection("Users").doc(user?.email).set(
    //   <String, dynamic>{
    //     "uid": user!.uid,
    //     "Name": user!.displayName,
    //     "Email": user!.email
    //   },
    // );\

    users = FirebaseAuth.instance.currentUser;
    print("add user ---${users!.email}");
    final userData = UserModel(
        userId: users!.uid,
        fullNames: users!.displayName ?? 'Not Getting Name',
        email: users!.email ?? 'Not Getting Email');

    db.collection("Users").doc(userData.email).set(
      <String, dynamic>{
        "uid": userData.userId,
        "Name": userData.fullNames,
        "Email": userData.email
      },
    );
  }

  @override
  Future bottomNavData() async {
    final bottomData = BottomNavModel(
        homeIcon: Icons.home.codePoint.toString(),
        homeTitle: 'Home',
        appointmentIcon: Icons.document_scanner.codePoint.toString(),
        appointmentTitle: 'Appointments',
        consultNowIcon: Icons.add.codePoint.toString(),
        consultNowTitle: 'Consult Now');

    await db.collection("BottomNav").doc('bottomNavCodeIcon').set(
      <String, dynamic>{
        "HomeIcon": bottomData.homeIcon,
        "HomeTitle": bottomData.homeTitle,
        "AppointmentsIcon": bottomData.appointmentIcon,
        "AppointmentsTitle": bottomData.appointmentTitle,
        "ConsultNowIcon": bottomData.consultNowIcon,
        "ConsultNowTitle": bottomData.consultNowTitle,
      },
    );
  }

  // add doctor card data
  // Add image url from firebase storage to firestore database
  @override
  Future addDoctorCardData() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('DoctorImages/doctor.png');
    var downloadUrl = await storageRef.getDownloadURL();

    final doctorData = DoctorCardModel(
        imageUrl: downloadUrl.toString(),
        name: 'Dr. U.S.Tiwari',
        speciality: 'General Physician(MBBS)');

    await db.collection('DoctorsData').doc('doctor_list').set(<String, dynamic>{
      "imageUrl": doctorData.imageUrl,
      "name": doctorData.name,
      "speciality": doctorData.speciality
    });
  }

  @override
  Future<dynamic> fetchUserData() async {
    users = FirebaseAuth.instance.currentUser;
    final personnalData =
        FirebaseFirestore.instance.collection('Users').doc(users!.email).get();

    return personnalData;
  }

  @override
  Future<dynamic> getIconFromFirestore() async {
    final iconFetchData =
        await db.collection('BottomNav').doc('bottomNavCodeIcon').get();

    return iconFetchData;
  }

  @override
  Future<dynamic> getDoctorCardData() async {
    final doctorData =
        await db.collection('DoctorsData').doc('doctor_list').get();
    return doctorData;
  }
}

returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    case 400:
      throw BadDataException(response.body.toString());
    case 500:
    case 404:
      throw UnauthorizedException(response.body.toString());
  }
}
