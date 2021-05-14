import 'package:amplify_todo/app_routes.dart';
import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/pages/landing_page.dart';
import 'package:amplify_todo/services/amplify_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put<AuthController>(AuthController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AmplifyService.configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      getPages: AppRoutes.routes,
    );
  }
}
