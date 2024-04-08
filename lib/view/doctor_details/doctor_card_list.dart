import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/arguments/doctor_details_arguments.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_card_list.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_details_screen.dart';
import 'package:mvvm_auth2/view_model/get_all_doctors_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/get_doctor_details_view_model.dart';

class DoctorCardList extends StatefulWidget {
  const DoctorCardList({super.key});

  @override
  State<DoctorCardList> createState() => _DoctorCardListState();
}

class _DoctorCardListState extends State<DoctorCardList> {
  List<DoctorCardModel> allDoctorList = [];

  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    final _getAllDoctorDetails = Provider.of<GetAllDoctorsViewModel>(context);

    _getAllDoctorDetails
        .getAllDoctorDetailsApi()
        .then((value) => allDoctorList = value);

    return Column(
      children: [
        FutureBuilder<List<DoctorCardModel>>(
          future: _getAllDoctorDetails.getAllDoctorDetailsApi(),
          builder: (context, AsyncSnapshot<List<DoctorCardModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Top Doctors for you',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: buttonPressed
                                  ? Text(
                                      'See less',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 37, 102, 137),
                                      ),
                                    )
                                  : Text(
                                      'See All',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 37, 102, 137),
                                      ),
                                    ),
                              onPressed: () {
                                setState(() {
                                  buttonPressed = !buttonPressed;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: buttonPressed ? allDoctorList.length : 1,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => DoctorDetailScreen(
                                            uid: snapshot.data![index].uid,
                                            fromAppointmentCarousel: false,
                                          )));
                            },
                            child: Card(
                              elevation: 50,
                              shadowColor: Colors.black,
                              // color: Color.fromARGB(255, 0, 112, 137),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Image.network(
                                        snapshot.data![index].imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      children: [
                                        Container(),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].uid
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                snapshot.data![index].name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              Text('no data');
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
