// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      doctorID: json['doctorID'] as int,
      userId: json['userId'] as String,
      selectDateTime: json['selectDateTime'] as int?,
      doctorCardModel: json['doctorCardModel'] == null
          ? null
          : DoctorCardModel.fromJson(
              json['doctorCardModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'doctorID': instance.doctorID,
      'userId': instance.userId,
      'selectDateTime': instance.selectDateTime,
      'doctorCardModel': instance.doctorCardModel,
    };
