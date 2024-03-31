import 'package:flutter/material.dart';
import 'package:mvvm_auth2/model/doctor_card_model.dart';
import 'package:mvvm_auth2/repository/get_all_doctors_repository.dart';
import 'package:mvvm_auth2/repository/get_bottom_icon_nav_repository.dart';

class GetAllDoctorsViewModel with ChangeNotifier {
  final _getAllDoctorDetailsRepo = getAllDoctorsRepository();

  Future<List<DoctorCardModel>> getAllDoctorDetailsApi() async {
    return _getAllDoctorDetailsRepo.fetchAllDoctorDetailsServices();
  }
}
