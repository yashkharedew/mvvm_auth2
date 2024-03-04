import 'package:mvvm_auth2/data/network/base_api_services.dart';
import 'package:mvvm_auth2/data/network/network_api_services.dart';

class AddUserRepository {
  final BaseApiServices _addUserService = NetworkApiServices();

  void addUserServiceRepo() {
    final response = _addUserService.addUserData();
  }
}
