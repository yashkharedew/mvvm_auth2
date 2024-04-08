// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';

part 'appointment_model.g.dart';

// for run build command,if exists first delete existing generated file and then run this command
// flutter pub run build_runner build

@JsonSerializable()
class AppointmentModel {
  late final int doctorID;
  final String userId;
  int? selectDateTime;
  DoctorCardModel? doctorCardModel;
  // final String imageUrl;
  // final String name;
  // final String speciality;
  AppointmentModel(
      {required this.doctorID,
      required this.userId,
      this.selectDateTime,
      this.doctorCardModel});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
