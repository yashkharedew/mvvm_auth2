import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class GetBottomIconNavRepository {
  final BaseApiServices _getBottomIconDataService = NetworkApiServices();

  Future<dynamic> fetchBottomIconServices() async {
    final response = await _getBottomIconDataService.getIconFromFirestore();
    return response;
  }
}
