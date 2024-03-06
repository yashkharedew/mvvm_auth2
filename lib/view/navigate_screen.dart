import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_auth2/repository/get_bottom_icon_nav_repository.dart';
import 'package:mvvm_auth2/view/appointments_tab_screen.dart';
import 'package:mvvm_auth2/view/consult_now_tab_screen.dart';
import 'package:mvvm_auth2/view/home_tab_screen.dart';
import 'package:mvvm_auth2/view/profile_screen.dart';
import 'package:mvvm_auth2/view/user_data/user_display_name.dart';
import 'package:mvvm_auth2/view_model/auth_view_model.dart';
import 'package:mvvm_auth2/view_model/get_bottom_icon_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/get_user_view_model.dart';

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
    final _getBottomIconViewModel =
        Provider.of<GetBottomIconViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          // title: const UserDisplayName(),
          // title: InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, RoutesName.profile);
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(8.0),
          //     decoration:
          //         BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          //     child: SvgPicture.asset(
          //       'assets/images/user_picture.svg',
          //       semanticsLabel: 'My SVG Image',
          //       width: 70,
          //       height: 70,
          //     ),
          //   ),
          // ),
          // leading: UserDisplayName(),
          actions: [
            Container(
              child: UserDisplayName(),
            ),
            SizedBox(
              width: 90,
            ),
            Container(
              child: InkWell(
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
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: FutureBuilder(
        future: _getBottomIconViewModel.getBottomIconDataApi(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconData(int.parse('${snapshot.data['HomeIcon']}'),
                            fontFamily: 'MaterialIcons'),
                      ),
                      label: snapshot.data['HomeTitle']),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconData(
                            int.parse('${snapshot.data['ConsultNowIcon']}'),
                            fontFamily: 'MaterialIcons'),
                      ),
                      label: snapshot.data['ConsultNowTitle']),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconData(
                            int.parse('${snapshot.data['AppointmentsIcon']}'),
                            fontFamily: 'MaterialIcons'),
                      ),
                      label: snapshot.data['AppointmentsTitle']),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color.fromARGB(255, 49, 132, 248),
                onTap: _onItemTapped,
              );
            }
          } else if (snapshot.hasError) {
            Text('no data');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
