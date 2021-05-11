import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthService {
  Future<void> signIn(AuthProvider authProvider) async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: authProvider);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  // Future<bool> registerWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     Map<String, String> userAttributes = {
  //       'email': email,
  //       'preferred_username': email,
  //       // additional attributes as needed
  //     };
  //     await Amplify.Auth.signUp(
  //         username: email,
  //         password: password,
  //         options: CognitoSignUpOptions(userAttributes: userAttributes));
  //     return true;
  //   } on AuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }

  // signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     SignInResult res = await Amplify.Auth.signIn(
  //       username: email.trim(),
  //       password: password.trim(),
  //     );

  //     isSignedIn = res.isSignedIn;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // confirmRegisterWithCode(String email, String code) async {
  //   try {
  //     SignUpResult res = await Amplify.Auth.confirmSignUp(
  //         username: email, confirmationCode: code);

  //     isSignedIn = res.isSignUpComplete;
  //   } on AuthException catch (e) {
  //     throw e;
  //   }
  // }
}
