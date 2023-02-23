import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/login_page/auth_page.dart';
// import 'package:hsmarthome/pages/new_page.dart';
// import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'HSmartHome',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // HomeController homeController = HomeController();

  final controller = Get.put(HomeController());
  // final home_led = Get.put(HomePage());
  HomePage home_led = new HomePage();

  void syncLed() {
    if (controller.ledToggled == true) {
      home_led.initialLed();
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.streamInit();
    syncLed();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
