import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_auth2/view/appointments_tab_screen.dart';
import 'package:mvvm_auth2/view/consult_now_tab_screen.dart';
import 'package:mvvm_auth2/view/home_tab_screen.dart';
import 'package:mvvm_auth2/view/profile_screen.dart';
import 'package:mvvm_auth2/view/user_data/user_display_name.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';

import '../utils/routes/routes_name.dart';

class NavigateScreen extends StatefulWidget {
  const NavigateScreen({super.key});

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  // Need to become consumer using provider
  // code here
  int _selectedIndex = 0;
  // List of pages
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: HomeTabScreen(),
    ),
    Container(
      child: AppointmentsTabScreen(),
    ),
    Container(
      child: ConsultNowTabScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
            title: const UserDisplayName(),
            leading: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.profile);
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: SvgPicture.asset(
                  'assets/images/user_picture.svg',
                  semanticsLabel: 'My SVG Image',
                  width: 70,
                  height: 70,
                ),
              ),
            )),
      ),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Consult Now'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 49, 132, 248),
        onTap: _onItemTapped,
      ),
    );
  }
}
