import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_todo/models/Users.dart';
import 'package:amplify_todo/services/datastore_service.dart';

class AuthService {
  DataStoreService _dataStoreService = DataStoreService();
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

  Future<AuthUser> getCurrentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }

  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      Map<String, String> userAttributes = {
        'email': email,
        'preferred_username': email,
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
        final signInRes = await signInWithEmailAndPassword(email, password);
        AuthUser authUser = await Amplify.Auth.getCurrentUser();
        Users user = new Users(
            id: authUser.userId,
            username: email,
            email: email,
            isVerified: true,
            createdAt: TemporalTimestamp.now());
        await _dataStoreService.saveUser(user);
        return signInRes;
      }
    } catch (e) {
      throw e;
    }
  }
}
