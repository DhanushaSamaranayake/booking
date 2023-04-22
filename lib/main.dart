import 'package:booking/controllers/auth_con.dart';
import 'package:booking/controllers/common_controller.dart';
import 'package:booking/controllers/location_con.dart';
import 'package:booking/pages/splash_screen_booking.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();
  Get.put(AuthController());
  Get.put(LocationController());
  Get.put(CommonController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
