import 'package:http/http.dart';
import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class AddDoctorDetailsRepository {
  final BaseApiServices _addDoctorDetails = NetworkApiServices();

  Future addDoctorDetailsService() async {
    final response = await _addDoctorDetails.addDoctorCardData();
    return response;
  }
}
