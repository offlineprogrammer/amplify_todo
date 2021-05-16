import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_todo/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmailSignInFormType { signIn, register, confirm }

class AuthController extends GetxController {
  static AuthController to = Get.find();
  RxBool isSignedIn = false.obs;
  AuthService _authService;
  Rx<EmailSignInFormType> emailformType = EmailSignInFormType.signIn.obs;
  RxBool isLoading = false.obs;
  bool submitted = false;
  RxBool submitEnabled = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final FocusNode codeFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';

  AuthController() {
    _authService = AuthService();
  }

  String get primaryButtonText {
    switch (emailformType.value) {
      case EmailSignInFormType.signIn:
        return 'Sign In';
      case EmailSignInFormType.register:
        return 'Create an account';
      case EmailSignInFormType.confirm:
        return 'Confirm Sign Up';
    }
  }

  String get secondaryButtonText {
    return emailformType.value == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  String get emailErrorText {
    bool showErrorText = submitted && !GetUtils.isEmail(emailController.text);
    update();
    return showErrorText ? invalidEmailErrorText : null;
  }

  void toggleFormType() {
    emailformType.value = emailformType.value == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    emailController.clear();
    passwordController.clear();
    submitted = false;
  }

  Future<void> submitEmailAndPassword() async {
    submitted = true;
    isLoading.value = true;

    try {
      switch (emailformType.value) {
        case EmailSignInFormType.signIn:
          isSignedIn.value = await _authService.signInWithEmailAndPassword(
              emailController.text, passwordController.text);
          // await Get.find<UserController>().getCurrUser();
          break;
        case EmailSignInFormType.register:
          final isSignedUp = await _authService.registerWithEmailAndPassword(
              emailController.text, passwordController.text);
          if (!isSignedUp) {
            emailformType.value = EmailSignInFormType.confirm;
          }
          break;
        case EmailSignInFormType.confirm:
          isSignedIn.value = await _authService.confirmRegisterWithCode(
              emailController.text,
              passwordController.text,
              codeController.text);
      }
    } catch (e) {
      //isLoading.value = false;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    isUserSignedIn();
    ever(isSignedIn, handleAuthChanged);
    super.onReady();
  }

  void isUserSignedIn() async {
    try {
      isSignedIn.value = await _authService.isSignedIn();
    } catch (e) {
      throw e;
    }
  }

  handleAuthChanged(isSignedIn) {
    if (!isSignedIn) {
      Get.offAllNamed("/");
    } else {
      Get.offAllNamed("/home");
    }
  }

  void signIn(AuthProvider authProvider) async {
    try {
      await _authService.signIn(authProvider);
    } catch (e) {
      throw e;
    }
  }

  void signOut() async {
    try {
      await _authService.signOut();
      isSignedIn.value = false;
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void updateform(String value) {
    submitEnabled.value = GetUtils.isEmail(emailController.text) &&
        !GetUtils.isBlank(passwordController.text) &&
        !isLoading.value;
  }
}
