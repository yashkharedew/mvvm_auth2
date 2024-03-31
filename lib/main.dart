import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_auth2/repository/get_bottom_icon_nav_repository.dart';
import 'package:mvvm_auth2/utils/routes/routes.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view/login_screen.dart';
import 'package:mvvm_auth2/view_model/add_bottom_nav_view_model.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';
import 'package:mvvm_auth2/view_model/add_user_view_model.dart';
import 'package:mvvm_auth2/view_model/get_all_doctors_view_model.dart';
import 'package:mvvm_auth2/view_model/get_bottom_icon_view_model.dart';
import 'package:mvvm_auth2/view_model/get_current_user_appointment_view_model.dart';
import 'package:mvvm_auth2/view_model/get_doctor_details_view_model.dart';
import 'package:mvvm_auth2/view_model/get_user_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<AddUserViewModel>(
            create: (_) => AddUserViewModel()),
        ChangeNotifierProvider<GetUserViewModel>(
            create: (_) => GetUserViewModel()),
        ChangeNotifierProvider<AddBottomNavViewModel>(
            create: (_) => AddBottomNavViewModel()),
        ChangeNotifierProvider<GetBottomIconViewModel>(
            create: (_) => GetBottomIconViewModel()),
        ChangeNotifierProvider<GetAllDoctorsViewModel>(
            create: (_) => GetAllDoctorsViewModel()),
        ChangeNotifierProvider<GetDoctorDetailsViewModel>(
            create: (_) => GetDoctorDetailsViewModel()),
        ChangeNotifierProvider<GetCurrentUserAppointmentViewModel>(
            create: (_) => GetCurrentUserAppointmentViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MVVM Firebase Authentication',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.signup,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
