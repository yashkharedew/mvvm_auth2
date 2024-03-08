import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class GetDoctorDetailsRepository {
  final BaseApiServices _getDoctorDetails = NetworkApiServices();

  Future<dynamic> fetchDoctorDetailsServices() async {
    final response = await _getDoctorDetails.getDoctorCardData();
    return response;
  }
}
