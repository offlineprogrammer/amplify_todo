import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_todo/buttons_enum.dart';
import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amplify Auth Demo'),
        elevation: 10,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            height: 50.0,
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            button: Buttons.Google,
            onPressed: () => controller.signIn(AuthProvider.google),
            color: Colors.white,
            text: 'Sign in with Google',
            textColor: Colors.black87,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            button: Buttons.Facebook,
            onPressed: () => controller.signIn(AuthProvider.facebook),
            color: Color(0xFF334D92),
            text: 'Sign in with Facebook',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            button: Buttons.Amazon,
            onPressed: () => controller.signIn(AuthProvider.amazon),
            color: Colors.black54,
            text: 'Sign in with Amazon',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            button: Buttons.Email,
            onPressed: () => Get.toNamed("/emaillogin"),
            color: Colors.deepOrange,
            text: 'Sign in with email',
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
