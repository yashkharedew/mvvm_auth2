import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvvm_auth2/utils/routes/routes_name.dart';
import 'package:mvvm_auth2/view_model/add_doctor_details_view_model.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';
import 'package:mvvm_auth2/view_model/add_user_view_model.dart';
import 'package:mvvm_auth2/view_model/get_current_user_appointment_view_model.dart';
import 'package:mvvm_auth2/view_model/get_doctor_details_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../resources/widgets/buttons.dart';
import '../resources/widgets/textButtons.dart';
import '../utils/utils.dart';
import '../view_model/add_bottom_nav_view_model.dart';
import '../view_model/add_user_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // value notifier
  late bool _obscurePassword = true;

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final addUserViewModel = Provider.of<AddUserViewModel>(context);
    final addBottomViewModel = Provider.of<AddBottomNavViewModel>(context);

    final getDoctorDetailsViewModel =
        Provider.of<GetDoctorDetailsViewModel>(context);
    final getCurrentUserAppointmentViewModel =
        Provider.of<GetCurrentUserAppointmentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                focusNode: nameFocusNode,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _passwordController,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: _obscurePassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Buttons(
                    BtnOnPress: () async {
                      if (_emailController.text.isEmpty) {
                        Utils.show_Simple_Snackbar(
                            context, 'Email', 'Email is empty');
                      } else if (_passwordController.text.isEmpty) {
                        Utils.show_Simple_Snackbar(
                            context, 'Password', 'Password is empty');
                      } else if (_passwordController.text.length < 6) {
                        Utils.show_Simple_Snackbar(
                            context, 'Password', 'Password is too short ');
                      } else {
                        final String email = _emailController.text.toString();
                        final String password =
                            _passwordController.text.toString();
                        final String username = _nameController.text.toString();
                        await authViewModel.signUpApi(
                            email, password, username, context);

                        // Navigator.pushNamed(context, RoutesName.profile);

                        // _addUserData();
                        addUserViewModel.addUserApi();
                        // final User? user = FirebaseAuth.instance.currentUser;

                        // user != null
                        //     ? Navigator.pushNamed(context, RoutesName.home)
                        //     : Navigator.pushNamed(context, RoutesName.signup);

                        // Navigator.pushNamed(context, RoutesName.profile);
                        FirebaseAuth.instance.currentUser != null
                            ? Navigator.pushNamed(
                                context, RoutesName.navigateScreen)
                            : Utils.toastMsg(
                                'Some Error occured! Again try to sign in');
                        print('Api hit');
                      }
                    },
                    BtnTitle: 'Signup'),
              ),
              SizedBox(
                height: 8,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       authViewModel.googleAuthApi();
              //       // Navigator.pushNamed(context, RoutesName.profile);
              //     },
              //     child: Text('Google Login')),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await authViewModel.googleAuthApi();
                    // Navigator.pushNamed(context, RoutesName.profile);

                    // _addUserData();
                    addUserViewModel.addUserApi();
                    FirebaseAuth.instance.currentUser != null
                        // ? await Navigator.pushNamed(
                        //         context, RoutesName.navigateScreen)
                        //     .then((value) => Future.wait([
                        //           addBottomViewModel.addBottomNavApi(),
                        //           addBottomViewModel.addDoctorDetailsApi()
                        //         ]))
                        ? await Future.wait([
                            Navigator.pushNamed(
                                context, RoutesName.navigateScreen),
                            addBottomViewModel.addBottomNavApi(),
                            addBottomViewModel.addDoctorDetailsApi(),

                            // getCurrentUserAppointmentViewModel
                            // .getCurrentUserAppointmentApi(),
                          ])
                        : Utils.toastMsg(
                            'Some Error occured! Again try to sign in');
                  },
                  child: Text('Google Login')),
              SizedBox(
                height: 8,
              ),
              Container(
                child: TextButtons(
                  TxtBtnOnPress: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  BtnText: 'Already have an account, Sign In',
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
