// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextButtons extends StatelessWidget {
  final VoidCallback? TxtBtnOnPress;

  final String BtnText;

  const TextButtons({
    Key? key,
    required this.TxtBtnOnPress,
    required this.BtnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: TxtBtnOnPress,
      child: Text(BtnText),
    );
  }
}
