import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/app/account_page/account_page.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:hsmarthome/pages/app/notification_page/noti_page.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if (_selectedIndex == 0) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const HomePage()),
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey[100],
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'null',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'null',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'null',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'null',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade500,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        children: <Widget>[
          HomePage(),
          Dashboard(),
          NotiPage(),
          AccountPage(),
        ],
        index: _selectedIndex,
      ),
    );
  }
}
