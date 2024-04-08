// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:time_slot/model/day_part.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';
import 'package:time_slot/time_slot.dart';

class DatePickerWidget extends StatefulWidget {
  final int docUid;

  const DatePickerWidget({
    Key? key,
    required this.docUid,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
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
            initTime: selectedTimeValue ?? dateTime,
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
            // dateTime,
            dateTime,
            initialSelectedDate: selectedValue ?? dateTime,
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

            db.collection('Appointments').add(<String, dynamic>{
              "doctorID": widget.docUid,
              "userId": users!.uid,
              "selectDateTime": appointmentTimeSlotTimeStamp,
            });
            await Navigator.pushNamed(context, RoutesName.navigateScreen);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 140, 232, 86)),
            child: Text(
              'Book Now',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
