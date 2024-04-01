// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      date: json['date'] as String,
      time: json['time'] as String,
      doctorID: json['doctorID'] as int,
      userId: json['userId'] as String,
      dateTime: json['dateTime'] as int?,
      timeMiliSeconds: json['timeMiliSeconds'] as int?,
      doctorCardModel: json['doctorCardModel'] == null
          ? null
          : DoctorCardModel.fromJson(
              json['doctorCardModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'doctorID': instance.doctorID,
      'userId': instance.userId,
      'dateTime': instance.dateTime,
      'timeMiliSeconds': instance.timeMiliSeconds,
      'doctorCardModel': instance.doctorCardModel,
    };
