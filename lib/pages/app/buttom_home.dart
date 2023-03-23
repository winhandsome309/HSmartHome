import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/app/account_page/account_page.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:hsmarthome/pages/app/notification_page/noti_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';

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

  static List<dynamic> _widgetOptions = <Widget>[
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
        // child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
      bottomNavigationBar: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(12),
          // margin: EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            // color: Color.fromRGBO(242, 242, 246, 1),
            color: const Color(0xFF17203A).withOpacity(0.5),

            // color: const Color.fromRGBO(34, 73, 87, 1).withOpacity(0.8),
            // color: Colors.white,
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
              // activeColor: Color.fromRGBO(242, 242, 246, 1),
              activeColor: const Color.fromRGBO(9, 210, 138, 1),
              // activeColor: const Colors.purple,

              // activeColor: const Color.fromRGBO(34, 73, 87, 1).withOpacity(0.8),

              // color: Colors.grey.shade500,
              color: Colors.black.withOpacity(0.3),
              iconSize: 26,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  // icon: Icons.insert_chart_outlined_outlined,
                  icon: Icons.query_stats,
                  text: 'Dashboard',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  icon: Icons.notifications_none,
                  text: 'Notifications',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                ),
                GButton(
                  icon: Icons.person_outline,
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
    // return GetMaterialApp(
    //   initialRoute: '/home',
    //   getPages: [
    //     GetPage(
    //       name: '/home',
    //       page: () => HomePage(),
    //       binding: HomePageBinding(),
    //     ),
    //     GetPage(
    //       name: '/dashboard',
    //       page: () => Dashboard(),
    //     ),
    //   ],
    // );
  }
}
