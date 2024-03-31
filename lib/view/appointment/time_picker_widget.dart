import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot.dart';
import 'package:time_slot/time_slot_from_interval.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  var selectTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TimesSlotGridViewFromInterval(
        locale: "en",
        initTime: selectTime,
        crossAxisCount: 4,
        selectedColor: Color.fromARGB(255, 62, 204, 243),
        timeSlotInterval: const TimeSlotInterval(
          start: TimeOfDay(hour: 10, minute: 30),
          end: TimeOfDay(hour: 18, minute: 0),
          interval: Duration(minutes: 30),
        ),
        onChange: (value) {
          setState(() {
            selectTime = value;
          });
        },
      ),
    );
  }
}
