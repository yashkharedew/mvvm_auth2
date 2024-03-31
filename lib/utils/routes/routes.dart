import 'package:flutter/material.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view/appointments_tab_screen.dart';
import 'package:mvvm_auth2/view/consult_now_tab_screen.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_card_list.dart';
import 'package:mvvm_auth2/view/doctor_details/doctor_details_screen.dart';
import 'package:mvvm_auth2/view/doctor_details/sample_doc_screen.dart';
import 'package:mvvm_auth2/view/home_tab_screen.dart';
import 'package:mvvm_auth2/view/navigate_screen.dart';
import 'package:mvvm_auth2/view/login_screen.dart';
import 'package:mvvm_auth2/view/profile_screen.dart';

import '../../view/signup_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.navigateScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavigateScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());

      case RoutesName.appointmentsTabScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AppointmentsTabScreen());

      case RoutesName.consultNowTabScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ConsultNowTabScreen());

      case RoutesName.homeTabScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeTabScreen());

      case RoutesName.sampleDocScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SampleDocScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
