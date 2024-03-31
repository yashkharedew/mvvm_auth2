// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      Date: json['Date'] as String,
      Time: json['Time'] as String,
      DoctorID: json['DoctorID'] as int,
      UserID: json['UserID'] as String,
      doctorCardModel: json['doctorCardModel'] == null
          ? null
          : DoctorCardModel.fromJson(
              json['doctorCardModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'Date': instance.Date,
      'Time': instance.Time,
      'DoctorID': instance.DoctorID,
      'UserID': instance.UserID,
      'doctorCardModel': instance.doctorCardModel,
    };
