// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/resources/colors.dart';

class Buttons extends StatelessWidget {
  VoidCallback? BtnOnPress;

  String BtnTitle;

  Buttons({
    Key? key,
    required this.BtnOnPress,
    required this.BtnTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: BtnOnPress,
      child: Text(BtnTitle),
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
    );
  }
}
