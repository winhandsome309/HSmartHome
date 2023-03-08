import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/app/account_page/account_page.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:hsmarthome/pages/app/notification_page/noti_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Dashboard(),
    NotiPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Color.fromRGBO(242, 242, 246, 1),
      bottomNavigationBar: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(12),
          // margin: EdgeInsets.symmetric(horizontal: 30),
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            // color: Color.fromRGBO(242, 242, 246, 1),
            color: Color(0xFF17203A).withOpacity(0.5),
            // boxShadow: [
            //   BoxShadow(
            //     // blurRadius: 5,
            //     color: Colors.black.withOpacity(0.1),
            //   ),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: GNav(
              gap: 8,
              activeColor: Colors.black,
              // color: Colors.grey.shade500,
              color: Colors.white,
              iconSize: 26,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Account',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
