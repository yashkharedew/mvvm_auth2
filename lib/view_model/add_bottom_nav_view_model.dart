import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/add_bottom_nav_repository.dart';

import '../repository/add_doctor_details_repository.dart';

class AddBottomNavViewModel with ChangeNotifier {
  final _addBottomNavRepo = AddBottomNavRepository();
  final _addDoctorDetailsRepo = AddDoctorDetailsRepository();

  Future addBottomNavApi() async {
    await _addBottomNavRepo.addBottomNavService();
  }

  Future addDoctorDetailsApi() async {
    await _addDoctorDetailsRepo.addDoctorDetailsService();
  }
}
