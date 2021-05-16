import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            await Get.find<UserController>().getCurrUser();
          },
          builder: (_) {
            if (_.user.email != null) {
              return Text("Welcome " + _.user.email);
            } else {
              return Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => controller.signOut(),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text('Test')),
      ),
    );
  }
}
