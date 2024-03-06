import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class AddBottomNavRepository {
  final BaseApiServices _addBottomNav = NetworkApiServices();

  Future addBottomNavService() async {
    final response = await _addBottomNav.bottomNavData();
    return response;
  }
}
