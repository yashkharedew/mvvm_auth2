import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_auth2/utils/routes/routes.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view/login_screen.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';
import 'package:mvvm_auth2/view_model/add_user_view_model.dart';
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
        ListenableProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ListenableProvider<AddUserViewModel>(create: (_) => AddUserViewModel()),
        ListenableProvider<GetUserViewModel>(create: (_) => GetUserViewModel())
      ],
      child: MaterialApp(
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
