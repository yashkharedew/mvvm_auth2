import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_details_screen.dart';
import 'package:provider/provider.dart';

import '../../model/appointment_model.dart';
import '../../view_model/get_doctor_details_view_model.dart';

class AppointmentCarousel extends StatefulWidget {
  const AppointmentCarousel({super.key});

  @override
  State<AppointmentCarousel> createState() => _AppointmentCarouselState();
}

class _AppointmentCarouselState extends State<AppointmentCarousel> {
  List<AppointmentModel> appointmentList = [];
  bool buttonPressed = false;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final _getDoctorDetails = Provider.of<GetDoctorDetailsViewModel>(context);
    _getDoctorDetails
        .getDoctorDetailsApi()
        .then((value) => {appointmentList = value});
    return FutureBuilder<List<AppointmentModel>>(
      future: _getDoctorDetails.getDoctorDetailsApi(),
      builder: (context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Text(
                        buttonPressed
                            ? 'All Appointments '
                            : 'Appointments Today',
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
                                  color: Color.fromARGB(255, 37, 102, 137),
                                ),
                              )
                            : Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 37, 102, 137),
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
                appointmentList.isNotEmpty
                    ? Transform.scale(
                        scaleY: 1.0,
                        child: FlutterCarousel.builder(
                            itemCount:
                                buttonPressed ? appointmentList.length : 1,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewitemIndex) =>
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorDetailScreen(
                                          uid: snapshot.data![itemIndex]
                                              .doctorCardModel!.uid,
                                          fromAppointmentCarousel: true,
                                          getDateTimeSelect: DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  snapshot.data![itemIndex]
                                                      .selectDateTime!),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 50,
                                    shadowColor: Colors.black,
                                    color: Color.fromARGB(255, 0, 112, 137),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: Image.network(
                                                    snapshot
                                                        .data![itemIndex]
                                                        .doctorCardModel!
                                                        .imageUrl,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.message,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data![itemIndex]
                                                            .doctorCardModel!
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data![itemIndex]
                                                            .doctorCardModel!
                                                            .speciality,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      (DateTime.fromMillisecondsSinceEpoch(snapshot
                                                                      .data![
                                                                          itemIndex]
                                                                      .selectDateTime!)
                                                                  .hour) >
                                                              12
                                                          ? Text(
                                                              '${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).hour}.${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).minute} PM',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              '${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).hour}.${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).minute} AM',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        '${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).day}.${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).month}.${DateTime.fromMillisecondsSinceEpoch(snapshot.data![itemIndex].selectDateTime!).year}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            options: CarouselOptions(
                              height: 160.0,
                              viewportFraction: buttonPressed ? 0.83 : 1.0,
                              initialPage: _current,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              controller: CarouselController(),
                              pageSnapping: true,
                              scrollDirection: Axis.horizontal,
                              pauseAutoPlayOnTouch: true,
                              pauseAutoPlayOnManualNavigate: true,
                              pauseAutoPlayInFiniteScroll: false,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              disableCenter: false,
                              showIndicator: false,
                              slideIndicator: CircularSlideIndicator(),
                              // onPageChanged: (index, reason) {
                              //   setState(() {
                              //     _current = index;
                              //   });
                              // },
                            )),
                      )
                    : Text('Currently you have no appointments')
              ],
            );
          }
        } else if (snapshot.hasError) {
          Text('no data');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
