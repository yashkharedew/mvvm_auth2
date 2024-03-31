// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_card_model.g.dart';

@JsonSerializable()
class DoctorCardModel {
  late final int uid;
  final String imageUrl;
  final String name;
  final String speciality;
  DoctorCardModel({
    required this.uid,
    required this.imageUrl,
    required this.name,
    required this.speciality,
  });

  factory DoctorCardModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorCardModelToJson(this);
}
