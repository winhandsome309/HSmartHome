import 'package:flutter/material.dart';
// import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:hsmarthome/pages/app/account_page/account_page.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:hsmarthome/pages/app/notification_page/noti_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';
// import 'package:hsmarthome/pages/dashboard_page/dashboard.dart';

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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Dashboard(),
    NotiPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      // bottomNavigationBar: BottomNavigationBar(
      //   // showSelectedLabels: false,
      //   // showUnselectedLabels: false,
      //   backgroundColor: Colors.grey[100],
      //   iconSize: 25,
      //   type: BottomNavigationBarType.fixed,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Account',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.grey.shade900,
      //   unselectedItemColor: Colors.grey.shade500,
      //   onTap: _onItemTapped,
      // ),
      // body: IndexedStack(
      //   children: <Widget>[
      //     HomePage(),
      //     Dashboard(),
      //     NotiPage(),
      //     AccountPage(),
      //   ],
      //   index: _selectedIndex,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: GNav(
              gap: 8,
              activeColor: Colors.black,
              color: Colors.grey.shade500,
              iconSize: 26,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                ),
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                ),
                GButton(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Account',
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
