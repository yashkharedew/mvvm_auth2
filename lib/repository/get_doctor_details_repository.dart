import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

import '../model/appointment_model.dart';

class GetDoctorDetailsRepository {
  final BaseApiServices _getDoctorDetails = NetworkApiServices();

  Future<List<AppointmentModel>> fetchDoctorDetailsServices() async {
    final response = await _getDoctorDetails.getDoctorCardData();
    return response;
  }
}
