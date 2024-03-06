import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view/user_data/user_display_name.dart';
import 'package:mvvm_auth2/view/user_data/user_email.dart';
import 'package:mvvm_auth2/view_model/add_user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view_model/auth_view_model.dart';
import '../view_model/get_user_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> personnalData =
      db.collection("Users").doc(user?.email).snapshots();
  // Logout user

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        actions: [
          InkWell(
            onTap: () async {
              setState(() {
                _signOut();
                authViewModel.passwordSignOutApi();
              });
              await Navigator.pushNamed(context, RoutesName.signup);
            },
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'))),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Card(
            borderOnForeground: true,
            color: Color.fromARGB(255, 220, 220, 220),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: UserDisplayName(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: UserEmail(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
