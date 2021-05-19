import 'package:amplify_todo/app_routes.dart';
import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/bindings/controllers_bindings.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:amplify_todo/pages/landing_page.dart';
import 'package:amplify_todo/pages/loading_page.dart';
import 'package:amplify_todo/services/amplify_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _configureAmplify();
    });
  }

  void _configureAmplify() async {
    await AmplifyService.configureAmplify();
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
      initialBinding: ControllersBindings(),
      title: 'Flutter ToDo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: _amplifyConfigured ? LoadingPage() : _waitForAmplify(),
      getPages: AppRoutes.routes,
    );
  }

  Scaffold _waitForAmplify() {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
