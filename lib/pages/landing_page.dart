import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/pages/home_page.dart';
import 'package:amplify_todo/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    // final AuthController authController =
    //     Get.put(AuthController()); //AuthController.to;
    return Obx(() {
      return (controller.currentUser.value != null) ? HomePage() : SignInPage();
    });
  }
}
