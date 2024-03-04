import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class AddBottomNavRepository {
  final BaseApiServices _addBottomNav = NetworkApiServices();

  void addBottomNavService() {
    final response = _addBottomNav.bottomNavData();
  }
}
