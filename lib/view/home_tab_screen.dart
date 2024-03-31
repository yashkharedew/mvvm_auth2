import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/view/appointment/date_picker_widget.dart';
import 'package:mvvm_auth2/view/appointment/time_picker_widget.dart';
import 'package:mvvm_auth2/view/doctor_details/appointements_list.dart';
import 'package:mvvm_auth2/view/doctor_details/collection_list.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_card.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_card_list.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  DateTime dateTime = DateTime.now();

  late DateTime selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppointmentsList(),
                  DoctorCardList(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
