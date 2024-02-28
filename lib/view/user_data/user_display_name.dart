import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/repository/get_user_repository.dart';
import 'package:mvvm_auth2/view_model/get_user_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';

final User? user = FirebaseAuth.instance.currentUser;
final FirebaseFirestore db = FirebaseFirestore.instance;
// late Stream<DocumentSnapshot<Map<String, dynamic>>> personnalData =
//     db.collection("Users").doc(user?.email).snapshots();

// Text(snapshot.data!['Email']);
class UserDisplayName extends StatefulWidget {
  const UserDisplayName({super.key});

  @override
  State<UserDisplayName> createState() => _UserDisplayNameState();
}

class _UserDisplayNameState extends State<UserDisplayName> {
  @override
  Widget build(BuildContext context) {
    final _getUserViewModel = Provider.of<GetUserViewModel>(context);

    return FutureBuilder(
      future: _getUserViewModel.getUserDataApi(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                // here only return is missing
                child: Text(
              snapshot.data!['Email'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ));
          }
        } else if (snapshot.hasError) {
          Text('no data');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
