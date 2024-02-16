import 'package:mvvm_auth2/data/network/BaseApiServices.dart';
import 'package:mvvm_auth2/data/network/NetworkApiServices.dart';

class AddUserRepository {
  final BaseApiServices _addUserService = NetworkApiServices();

  void addUserServiceRepo() {
    final response = _addUserService.addUserData();
  }
}
