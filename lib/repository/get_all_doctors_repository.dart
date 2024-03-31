import 'package:mvvm_auth2/model/doctor_card_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class getAllDoctorsRepository {
  final BaseApiServices _getAllDoctorsDetails = NetworkApiServices();

  Future<List<DoctorCardModel>> fetchAllDoctorDetailsServices() async {
    final response = await _getAllDoctorsDetails.getAllDoctorList();
    return response;
  }
}
