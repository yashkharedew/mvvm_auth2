// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/view/doctor_details/appointements_list.dart';
import 'package:provider/provider.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

import '../../model/appointment_model.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/get_doctor_details_view_model.dart';

class UpdatedDatePicker extends StatefulWidget {
  final int docUid;
  final DateTime timeSelect;
  final DateTime dateSelect;

  const UpdatedDatePicker({
    Key? key,
    required this.docUid,
    required this.timeSelect,
    required this.dateSelect,
  }) : super(key: key);

  @override
  State<UpdatedDatePicker> createState() => _UpdatedDatePickerState();
}

class _UpdatedDatePickerState extends State<UpdatedDatePicker> {
  DateTime dateTime = DateTime.now();

  DateTime? selectedValue;

  DateTime? selectedTimeValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TimesSlotGridViewFromInterval(
            locale: "en",
            initTime: selectedTimeValue ?? widget.timeSelect,
            crossAxisCount: 4,
            selectedColor: Color.fromARGB(255, 62, 204, 243),
            timeSlotInterval: const TimeSlotInterval(
              start: TimeOfDay(hour: 10, minute: 30),
              end: TimeOfDay(hour: 18, minute: 0),
              interval: Duration(minutes: 30),
            ),
            onChange: (time) {
              setState(() {
                selectedTimeValue = time;
              });
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: DatePicker(
            dateTime,
            initialSelectedDate: selectedValue ?? widget.dateSelect,
            selectionColor: Color.fromARGB(255, 62, 204, 243),
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              setState(
                () {
                  selectedValue = date;
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () async {
            final User? users = FirebaseAuth.instance.currentUser;
            final FirebaseFirestore db = FirebaseFirestore.instance;
            final dateTimeMiliSeconds = selectedValue!.microsecondsSinceEpoch;
            final appointedDay = selectedValue!.day;
            final appointedMonth = selectedValue!.month;
            final appointedYear = selectedValue!.year;
            final timeMiliSeconds = selectedTimeValue!.millisecondsSinceEpoch;
            final timeslot_hours = selectedTimeValue!.hour;
            final timeslot_minutes = selectedTimeValue!.minute;
            final appointmentTime = timeslot_hours > 12
                ? (timeslot_hours - 12).toString() +
                    '.' +
                    timeslot_minutes.toString() +
                    'PM'
                : timeslot_hours.toString() +
                    '.' +
                    timeslot_minutes.toString() +
                    'AM';

            final String appointementDate =
                '$appointedDay.$appointedMonth.$appointedYear';
            final appointmentTimeSlot = DateTime(
                appointedYear,
                appointedMonth,
                appointedDay,
                timeslot_hours,
                timeslot_minutes,
                selectedTimeValue!.millisecond,
                selectedTimeValue!.microsecond);

            final appointmentTimeSlotTimeStamp =
                appointmentTimeSlot.millisecondsSinceEpoch;

            var collection = db
                .collection('Appointments')
                .where('userId', isEqualTo: users!.uid)
                .where('doctorID', isEqualTo: widget.docUid);
            var querySnapshots = await collection.get();
            for (var doc in querySnapshots.docs) {
              await doc.reference.update(<String, dynamic>{
                "date": appointementDate,
                "time": appointmentTime,
                "doctorID": widget.docUid,
                "userId": users.uid,
                "dateTime": dateTimeMiliSeconds,
                "timeMiliSeconds": timeMiliSeconds,
                "selectDateTime": appointmentTimeSlotTimeStamp,
              });
            }
            await Navigator.pushNamed(context, RoutesName.navigateScreen);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 140, 232, 86)),
            child: Text(
              'Update Now',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
