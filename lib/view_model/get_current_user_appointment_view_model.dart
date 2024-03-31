import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/get_curent_user_appointment_repository.dart';

class GetCurrentUserAppointmentViewModel with ChangeNotifier {
  final _getCurrentUserAppointmentRepo = GetCurrentUserAppointmentRepository();
  Future<dynamic> getCurrentUserAppointmentApi() async {
    return _getCurrentUserAppointmentRepo.getCurrentUserAppointmentService();
  }
}
