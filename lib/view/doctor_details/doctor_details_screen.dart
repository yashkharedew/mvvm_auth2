// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/arguments/doctor_details_arguments.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
import 'package:mvvm_auth2/view/appointment/update_date_picker.dart';

import '../appointment/date_picker_widget.dart';

class DoctorDetailScreen extends StatefulWidget {
  final int uid;
  final bool fromAppointmentCarousel;
  final DateTime? getTimeSelect;
  final DateTime? getDateSelect;

  const DoctorDetailScreen({
    Key? key,
    required this.uid,
    required this.fromAppointmentCarousel,
    this.getTimeSelect,
    this.getDateSelect,
  }) : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as DoctorDetailsArguments?;
    print('screen arguments is == ${widget.uid}');

    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('DoctorsData')
            .doc(widget.uid.toString())
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SafeArea(
                child: Center(
                  // here only return is missing
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.all(16),
                        color: Color.fromARGB(255, 0, 112, 137),
                        child: Text(
                          'Detail Doctor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Image.network(
                            snapshot.data!['imageUrl'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          snapshot.data!['name'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          snapshot.data!['speciality'],
                          style: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color.fromARGB(255, 208, 229, 255),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Patients',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 164, 164, 164),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data['patients'].toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 102, 137),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              width: 2,
                              height: 28,
                              color: Color.fromARGB(255, 202, 202, 202),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Experience',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 164, 164, 164),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      ' ${snapshot.data['experience'].toString()} yrs',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 102, 137),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              width: 2,
                              height: 28,
                              color: Color.fromARGB(255, 202, 202, 202),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 164, 164, 164),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data['rating'].toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 102, 137),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Doctor',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 164, 164, 164),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.fromAppointmentCarousel
                              ? UpdatedDatePicker(
                                  docUid: snapshot.data!['uid'],
                                  dateSelect: widget.getDateSelect as DateTime,
                                  timeSelect: widget.getTimeSelect as DateTime,
                                )
                              : DatePickerWidget(
                                  docUid: snapshot.data!['uid'],
                                ))
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            Text('no data');
          }
          return CircularProgressIndicator();
        },
      ),
    );

    // return Scaffold(
    //   body: SafeArea(child: Text(args.toString())),
    // );
  }
}
