import 'package:amplify_todo/app_routes.dart';
import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/bindings/authBinding.dart';
import 'package:amplify_todo/pages/landing_page.dart';
import 'package:amplify_todo/pages/loading_page.dart';
import 'package:amplify_todo/services/amplify_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Get.put<AuthController>(AuthController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Once Plugins are added, configure Amplify
    await AmplifyService.configureAmplify();
    Get.put<AuthController>(AuthController());
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //  initialBinding: AuthBinding(),

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _amplifyConfigured ? LandingPage() : LoadingPage(),
      getPages: AppRoutes.routes,
    );
  }
}
