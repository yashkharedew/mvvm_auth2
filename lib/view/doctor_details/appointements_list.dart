import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/model/appointment_model.dart';
import 'package:mvvm_auth2/view_model/get_doctor_details_view_model.dart';
import 'package:provider/provider.dart';

class AppointmentsList extends StatefulWidget {
  const AppointmentsList({super.key});

  @override
  State<AppointmentsList> createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  List<AppointmentModel> appointmentList = [];

  bool buttonPressed = false;
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
                        'Appointments Today',
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
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: buttonPressed ? appointmentList.length : 1,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Color.fromARGB(255, 0, 112, 137),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          child: Image.network(
                                            snapshot.data![index]
                                                .doctorCardModel!.imageUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.message,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .doctorCardModel!.name,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .doctorCardModel!
                                                    .speciality,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              Text(
                                                snapshot.data![index].time,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                snapshot.data![index].date,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          );
                        },
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
