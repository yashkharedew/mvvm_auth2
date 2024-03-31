import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/get_bottom_icon_nav_repository.dart';
import 'package:mvvm_auth2/repository/get_doctor_details_repository.dart';

import '../model/appointment_model.dart';

class GetDoctorDetailsViewModel with ChangeNotifier {
  final getDoctorDetailsRepo = GetDoctorDetailsRepository();

  Future<List<AppointmentModel>> getDoctorDetailsApi() async {
    return getDoctorDetailsRepo.fetchDoctorDetailsServices();
  }
}
