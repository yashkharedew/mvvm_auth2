import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class GetCurrentUserAppointmentRepository {
  final BaseApiServices _getBottomIconDataService = NetworkApiServices();

  Future<dynamic> getCurrentUserAppointmentService() async {
    final response = await _getBottomIconDataService.getAppointmentData();
    return response;
  }
}
