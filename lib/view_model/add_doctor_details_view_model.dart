import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/add_doctor_details_repository.dart';

class AddDoctorDetailsViewModel with ChangeNotifier {
  final _addDoctorDetailsRepo = AddDoctorDetailsRepository();

  Future addDoctorDetailsApi() async {
    await _addDoctorDetailsRepo.addDoctorDetailsService();
  }
}
