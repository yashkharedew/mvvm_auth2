import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppointmentsTabScreen extends StatefulWidget {
  const AppointmentsTabScreen({super.key});

  @override
  State<AppointmentsTabScreen> createState() => _AppointmentsTabScreenState();
}

class _AppointmentsTabScreenState extends State<AppointmentsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Appointments tab screen '));
  }
}
