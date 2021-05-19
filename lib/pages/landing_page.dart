import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/pages/home_page.dart';
import 'package:amplify_todo/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
