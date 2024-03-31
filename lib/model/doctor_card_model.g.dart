// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorCardModel _$DoctorCardModelFromJson(Map<String, dynamic> json) =>
    DoctorCardModel(
      uid: json['uid'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      speciality: json['speciality'] as String,
    );

Map<String, dynamic> _$DoctorCardModelToJson(DoctorCardModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'speciality': instance.speciality,
    };
