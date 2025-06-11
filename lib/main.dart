import 'package:apex_test/view/login_view.dart';
import 'package:apex_test/view/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hospital Kiosk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(source: 'main'),
      getPages: [
        GetPage(name: '/login', page: () => LoginView(source: 'main')),
        GetPage(
          name: '/otp',
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;

            // Fallback values for safety
            final source = args?['source'] ?? 'unknown';
            final mobileNumber = args?['mobileNumber'] ?? '';

            return OtpScreenView(
              source: source,
              mobileNumber: mobileNumber,
            );
          },
        ),
      ],
    );
  }
}
