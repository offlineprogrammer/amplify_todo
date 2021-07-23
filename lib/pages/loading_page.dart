import 'package:amplify_todo/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text('ToDo App')),
      body: Container(
        // color: Color(0xff90CCE6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Color(0xffE1E5E4),
                // height: 200,
                child: Image.asset(
                  'images/aws.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffE1E5E4),
    );
  }
}
