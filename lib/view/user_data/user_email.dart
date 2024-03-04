import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_auth2/view_model/get_user_view_model.dart';
import 'package:provider/provider.dart';

class UserEmail extends StatefulWidget {
  const UserEmail({super.key});

  @override
  State<UserEmail> createState() => _UserEmailState();
}

class _UserEmailState extends State<UserEmail> {
  @override
  Widget build(BuildContext context) {
    final _getUserViewModel = Provider.of<GetUserViewModel>(context);

    return FutureBuilder(
        future: _getUserViewModel.getUserDataApi(),
        builder: (BuildContext, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                  // here only return is missing
                  child: Text(
                snapshot.data!['Email'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ));
            }
          } else if (snapshot.hasError) {
            Text('no data');
          }
          return CircularProgressIndicator();
        });
  }
}
