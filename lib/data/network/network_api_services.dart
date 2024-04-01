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
import 'package:mvvm_auth2/model/appointment_model.dart';
import 'package:mvvm_auth2/model/bottom_nav_model.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
import 'package:mvvm_auth2/model/user_model.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_card.dart';

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
      uid: 101,
      imageUrl: downloadUrl.toString(),
      name: 'Dr. U.S.Tiwari',
      speciality: 'General Physician(MBBS)',
    );

    await db
        .collection('DoctorsData')
        .doc(doctorData.uid.toString())
        .set(<String, dynamic>{
      "uid": doctorData.uid,
      "imageUrl": doctorData.imageUrl,
      "name": doctorData.name,
      "speciality": doctorData.speciality
    });
  }

  @override
  // add appointment data
  // Future addAppointmentData() async {
  //   users = FirebaseAuth.instance.currentUser;
  //   final appointmentData = AppointmentModel(
  //     Date: '12.3.24',
  //     Time: '3.20PM',
  //     DoctorID: 100,
  //     UserID: users!.uid,
  //   );
  //   await db.collection('Appointments').add(<String, dynamic>{
  //     "Date": appointmentData.Date,
  //     "Time": appointmentData.Time,
  //     "DoctorID": appointmentData.DoctorID,
  //     "UserID": appointmentData.UserID,
  //   });
  // }

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

  // Getting all doctor data list
  @override
  Future<List<DoctorCardModel>> getAllDoctorList() async {
    List<DoctorCardModel> allDoctorList = [];

    final allDoctorData =
        await db.collection('DoctorsData').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) async {
        allDoctorList
            .add(DoctorCardModel.fromJson(doc.data() as Map<String, dynamic>));
      });
    });

    return allDoctorList;
  }

// getting appointed doctor details
  @override
  Future<List<AppointmentModel>> getDoctorCardData() async {
    List<AppointmentModel> appointmentList = [];
    users = FirebaseAuth.instance.currentUser;

    // final appointmentData = await db
    //     .collection('Appointments')
    //     .where('UserID', isEqualTo: users!.uid)
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((doc) async {
    //     appointmentList
    //         .add(AppointmentModel.fromJson(doc.data() as Map<String, dynamic>));
    //   });
    // });

    // for (int i = 0; i < appointmentList.length; i++) {
    //   final doctorsData = await db
    //       .collection('DoctorsData')
    //       .where('uid', isEqualTo: appointmentList[i].DoctorID)
    //       .get()
    //       .then((QuerySnapshot snapshot) {
    //     snapshot.docs.forEach((doc) async {
    //       appointmentList[i] = AppointmentModel(
    //           Date: appointmentList[i].Date,
    //           Time: appointmentList[i].Time,
    //           DoctorID: appointmentList[i].DoctorID,
    //           UserID: appointmentList[i].UserID,
    //           doctorCardModel:
    //               DoctorCardModel.fromJson(doc.data() as Map<String, dynamic>));
    //     });
    //   });
    // }
    // for (var element in appointmentList) {
    //   print('appointment list item ${element.DoctorID}');
    //   print(element);
    // }
    // return appointmentList;
    var appointedDoctor;
    final appointments = await db
        .collection('Appointments')
        .where('userId', isEqualTo: users!.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) async {
        appointmentList
            .add(AppointmentModel.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
    print('current user = ${users!.uid}');
    print('appointment list == ${appointmentList.length}');

    for (final appointment in appointmentList) {
      print('appointment Doctor == ${appointment.doctorID}');
      final QuerySnapshot doctorData = await db
          .collection('DoctorsData')
          .where('uid', isEqualTo: appointment.doctorID)
          .get();

      final doctor = doctorData.docs.first;
      print('filtered doctor data== ${doctor.data()}');
      appointment.doctorCardModel =
          DoctorCardModel.fromJson(doctor.data() as Map<String, dynamic>);
    }
    // take refrence for sorting
    appointmentList.sort((a, b) => a.dateTime!.compareTo(b.dateTime as num));
    appointmentList
        .sort((a, b) => a.timeMiliSeconds!.compareTo(b.timeMiliSeconds as num));

    print('First element of appointed doctor ${appointmentList}}');

    // Getting Doctors Data after getting appointed Doctor from comparing Doctors and current user appointment

    return appointmentList;
  }

  @override
  Future<dynamic> getAppointmentData() async {
    // List<dynamic> appointment = [];
    // List<dynamic> doctor = [];
    // users = FirebaseAuth.instance.currentUser;
    // final appointmentData = await db
    //     .collection('Appointments')
    //     .where('UserID', isEqualTo: users!.uid)
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((element) async {
    //     print('${element['DoctorID']}');
    //     // Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    //     // appointment.add(data);
    //     // appointment.add(element.data());
    //   });
    // });
    // print('doctor name : ${appointment[0]['name']}');
    // return appointmentData;
  }

  @override
  Future<dynamic> getCommonDoctorData() async {
    List<dynamic> appointmentList = [];
    CollectionReference appointmentDetails =
        FirebaseFirestore.instance.collection('Appointments');

    QuerySnapshot querySnapshot =
        await appointmentDetails.where('UserID', isEqualTo: users!.uid).get();
    querySnapshot.docs.forEach((doc) {
      appointmentList
          .add(AppointmentModel.fromJson(doc.data() as Map<String, dynamic>));
      for (var element in appointmentList) {
        print(
            'Date: ${element.Date}, Name: ${element.Time}, Email: ${element.DoctorID}');
      }
    });
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
