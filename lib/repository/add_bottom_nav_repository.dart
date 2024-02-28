import 'package:mvvm_auth2/data/network/BaseApiServices.dart';
import 'package:mvvm_auth2/data/network/NetworkApiServices.dart';

class AddBottomNavRepository {
  final BaseApiServices _addBottomNav = NetworkApiServices();

  void addBottomNavService() {
    final response = _addBottomNav.bottomNavData();
  }
}
