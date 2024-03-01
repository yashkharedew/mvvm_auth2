import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvvm_auth2/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_auth2/model/bottom_nav_model.dart';
import 'package:mvvm_auth2/model/user_model.dart';

import '../app_exception.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson;
  User? user = FirebaseAuth.instance.currentUser;
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
  Future signUpAuth(email, password, username) async {
    final UserCredential credential;
    try {
      credential = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));
      user = credential.user;
      print(user!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw BadDataException(e.toString());
      } else if (e.code == 'email-already-in-use') {
        throw UnauthorizedException(e.toString());
      }
    }
  }

  @override
  void signInAuth(email, password) async {
    final credential;
    try {
      credential = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
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
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

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

        user = userCredential.user;
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

    return user;
  }

  @override
  void passwordSignOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<dynamic> getUserAuthData(User user) async {
    // TODO: implement getUserAuthData
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User Display Name: ${user.displayName}");
      print("User Email: ${user.email}");
      print("User Photo URL: ${user.photoURL}");
      // Add more fields as needed
    } else {
      throw BadDataException('user not found');
    }
    return user;
  }

  @override
  void addUserData() {
    // db.collection("Users").doc(user?.email).set(
    //   <String, dynamic>{
    //     "uid": user!.uid,
    //     "Name": user!.displayName,
    //     "Email": user!.email
    //   },
    // );\

    final user = FirebaseAuth.instance.currentUser;
    print("add user ---${user!.email}");
    final userData = UserModel(
        userId: user!.uid,
        fullNames: user!.displayName ?? 'Not Getting UserName',
        email: user!.email ?? 'Not Getting Email');

    db.collection("Users").doc(userData.email).set(
      <String, dynamic>{
        "uid": userData.userId,
        "Name": userData.fullNames,
        "Email": userData.email
      },
    );
  }

  @override
  void bottomNavData() {
    final bottomData = BottomNavModel(
      bt1: 'btm1',
      bt2: 'btm2',
      bt3: 'btm3',
    );

    db.collection("Users").doc('BottomNav').set(
      <String, dynamic>{
        "bottom1": bottomData.bt1,
        "bottom2": bottomData.bt2,
        "bottom3": bottomData.bt3,
      },
    );
  }

  @override
  Future<dynamic> fetchUserData() async {
    final personnalData =
        FirebaseFirestore.instance.collection('Users').doc(user!.email).get();

    return personnalData;
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
