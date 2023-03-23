import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:hsmarthome/pages/app/buttom_home.dart';
import 'package:hsmarthome/pages/app/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppPages {
  static const INITIAL = 'Home';

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.SPLASH_SCREEN,
    //   page: () => SplashScreenView(),
    //   binding: SplashScreenBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CONNECTED_DEVICE,
    //   page: () => ConnectedDeviceView(),
    //   binding: ConnectedDeviceBinding(),
    // ),
  ];
}

abstract class Routes {
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  static const HOME = '/home';
}
