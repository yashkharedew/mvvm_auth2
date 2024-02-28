import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/add_bottom_nav_repository.dart';

class AddBottomNavViewModel with ChangeNotifier {
  final _addBottomNavRepo = AddBottomNavRepository();

  void addBottomNavApi() {
    _addBottomNavRepo.addBottomNavService();
  }
}
