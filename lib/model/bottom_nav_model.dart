// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BottomNavModel {
  final String homeIcon;
  final String homeTitle;
  final String appointmentIcon;
  final String appointmentTitle;
  final String consultNowIcon;
  final String consultNowTitle;

  BottomNavModel(
      {required this.homeIcon,
      required this.homeTitle,
      required this.appointmentIcon,
      required this.appointmentTitle,
      required this.consultNowIcon,
      required this.consultNowTitle});
}
