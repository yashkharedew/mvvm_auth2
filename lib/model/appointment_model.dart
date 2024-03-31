import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
part 'appointment_model.g.dart';

// for run build command,if exists first delete existing generated file and then run this command
// flutter pub run build_runner build

@JsonSerializable()
class AppointmentModel {
  final String Date;
  final String Time;
  late final int DoctorID;
  final String UserID;
  DoctorCardModel? doctorCardModel;
  // final String imageUrl;
  // final String name;
  // final String speciality;
  AppointmentModel(
      {required this.Date,
      required this.Time,
      required this.DoctorID,
      required this.UserID,
      this.doctorCardModel
      // required this.imageUrl,
      // required this.name,
      // required this.speciality
      });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
