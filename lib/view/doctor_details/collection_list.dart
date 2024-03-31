import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../view_model/get_current_user_appointment_view_model.dart';
import '../../view_model/get_user_view_model.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({super.key});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    final getCurrentUserAppointmentViewModel =
        Provider.of<GetCurrentUserAppointmentViewModel>(context);
    final users = FirebaseAuth.instance.currentUser;
    // return Expanded(
    //   child: StreamBuilder(
    //       stream: FirebaseFirestore.instance
    //           .collection('Appointments')
    //           .where('UserID', isEqualTo: users!.uid)
    //           .snapshots(),
    //       builder:
    //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //         if (!snapshot.hasData) return CircularProgressIndicator();
    //         return new ListView(children: getCollectionList(snapshot));
    //       }),
    // );
    return Container();
  }

  getCollectionList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => Container(
              width: double.infinity,
              height: 180,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Color.fromARGB(255, 0, 112, 137),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // DoctorImage(),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['DoctorID'].toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              doc['UserID'],
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }
}
