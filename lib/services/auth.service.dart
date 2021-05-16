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

  Future<bool> isSignedIn() async {
    AuthSession authSessions = await Amplify.Auth.fetchAuthSession();
    return authSessions.isSignedIn;
  }

  Future<bool> getCurrUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();

    return authUser.userId.isNotEmpty;
  }

  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      Map<String, String> userAttributes = {
        'email': email,
        'preferred_username': email,
        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      return res.isSignUpComplete;
    } on AuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await signOut();
      SignInResult res = await Amplify.Auth.signIn(
        username: email.trim(),
        password: password.trim(),
      );

      return res.isSignedIn;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> confirmRegisterWithCode(
      String email, String password, String code) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: code);

      if (res.isSignUpComplete) {
        return await signInWithEmailAndPassword(email, password);
      }
    } catch (e) {
      throw e;
    }
  }
}
