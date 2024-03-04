import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConsultNowTabScreen extends StatefulWidget {
  const ConsultNowTabScreen({super.key});

  @override
  State<ConsultNowTabScreen> createState() => _ConsultNowTabScreenState();
}

class _ConsultNowTabScreenState extends State<ConsultNowTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Text('Consult Now tab screen'),
      ),
    );
  }
}
