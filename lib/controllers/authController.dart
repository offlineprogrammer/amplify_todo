import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'package:amplify_todo/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmailSignInFormType { signIn, register, confirm }

class AuthController extends GetxController {
  static AuthController to = Get.find();
  //RxBool isSignedIn = false.obs;
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
          await _authService.signInWithEmailAndPassword(
              emailController.text, passwordController.text);
          _setuplistener();
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
          await _authService.confirmRegisterWithCode(emailController.text,
              passwordController.text, codeController.text);
          _setuplistener();
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
    // ever(isSignedIn, handleAuthChanged);
    _setuplistener();

    super.onReady();
  }

  void _setuplistener() {
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      print(hubEvent.eventName);
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("USER IS SIGNED IN");
            //   isSignedIn.value = true;
            Get.offAllNamed("/home");
          }
          break;
        case "SIGNED_OUT":
          {
            print("USER IS SIGNED OUT");
            Get.offAllNamed("/signin");
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("USER IS SIGNED IN");
            Get.offAllNamed("/signin");
          }
          break;
      }
    });
  }

  void isUserSignedIn() async {
    try {
      print('isUserSignedIn');
      isLoading.value = true;
      _setuplistener();
      bool _isSignedIn = await _authService.isSignedIn();
      if (!_isSignedIn) {
        Get.offAllNamed("/signin");
      } else {
        Get.offAllNamed("/home");
      }
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  handleAuthChanged(isSignedIn) {
    if (!isSignedIn) {
      Get.offAllNamed("/signin");
    } else {
      Get.offAllNamed("/home");
    }
  }

  void signIn(AuthProvider authProvider) async {
    try {
      await _authService.signIn(authProvider);
      _setuplistener();
    } catch (e) {
      throw e;
    }
  }

  void signOut() async {
    try {
      await _authService.signOut();
      //   isSignedIn.value = false;
      isLoading.value = false;
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
