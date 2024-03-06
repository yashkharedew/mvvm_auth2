import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/get_bottom_icon_nav_repository.dart';

class GetBottomIconViewModel with ChangeNotifier {
  final _getBottomIconRepo = GetBottomIconNavRepository();

  Future<dynamic> getBottomIconDataApi() async {
    return _getBottomIconRepo.fetchBottomIconServices();
  }
}
