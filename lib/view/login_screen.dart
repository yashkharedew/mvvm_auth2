import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/utils/utils.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../resources/widgets/buttons.dart';
import '../resources/widgets/textButtons.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/add_user_view_model.dart';
import '../view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // value notifier
  late bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final addUserViewModel = Provider.of<AddUserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: SafeArea(
        child: Center(
          // child: InkWell(
          //   onTap: () {
          //     // Utils.toastMsg('Hi Yash! this is a toast message');
          //     Utils.show_Simple_Snackbar(
          //         context, 'Hi Yash', 'This is description');
          //   },
          //   child: Text('Click Here'),
          // ),
          child: Column(
            children: [
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
                    BtnOnPress: () {
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
                        var email = _emailController.text.toString();
                        var password = _passwordController.text.toString();

                        authViewModel.signInApi(email, password, context);
                        // Navigator.pushNamed(context, RoutesName.profile);
                        addUserViewModel.addUserApi();
                        // final User? user = FirebaseAuth.instance.currentUser;
                        // user != null
                        //     ? Navigator.pushNamed(context, RoutesName.home)
                        //     : Navigator.pushNamed(context, RoutesName.signup);
                        FirebaseAuth.instance.currentUser != null
                            ? Navigator.pushNamed(context, RoutesName.profile)
                            : Utils.toastMsg(
                                'Some Error occured! Again try to sign in');
                        print('Api hit');
                      }
                    },
                    BtnTitle: 'Login'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: TextButtons(
                  TxtBtnOnPress: () {
                    Navigator.pushNamed(context, RoutesName.signup);
                  },
                  BtnText: 'Already have an account, Sign In',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
