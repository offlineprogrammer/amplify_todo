import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_todo/controllers/validators.dart';
import 'package:amplify_todo/models/Users.dart';
import 'package:amplify_todo/services.dart/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmailSignInFormType { signIn, register, confirm }

class AuthController extends GetxController with EmailAndPasswordValidator {
  static AuthController to = Get.find();
  RxBool isSignedIn = false.obs;
  AuthService _authService;
  Rx<Users> currentUser = null.obs;
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

  //RxString secondaryButtonText = 'Register'.obs;

  //String get user => currentUser?.value?.email;

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
    bool showErrorText =
        submitted && !emailValidator.isValid(emailController.text);
    update();
    return showErrorText ? invalidEmailErrorText : null;
  }

  void change() => isSignedIn.value = !isSignedIn.value;

  void toggleFormType() {
    print(emailformType.value);
    emailformType.value = emailformType.value == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    emailController.clear();
    passwordController.clear();
  }

  Future<void> submitEmailAndPassword() async {
    submitted = true;
    isLoading.value = true;

    try {
      switch (emailformType.value) {
        case EmailSignInFormType.signIn:
          // final user =
          //     await appUser.signInWithEmailAndPassword(email, password);
          break;
        case EmailSignInFormType.register:
          // final isSignedUp =
          //     await appUser.registerWithEmailAndPassword(email, password);
          // if (isSignedUp) {
          //   updateWith(
          //       formType: EmailSignInFormType.confirm,
          //       isLoading: false,
          //       submitted: false);
          // }
          break;
        case EmailSignInFormType.confirm:
        // final user = await appUser.confirmRegisterWithCode(email, code);
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
    ever(isSignedIn, handleAuthChanged);
    super.onInit();
  }

  handleAuthChanged(isSignedIn) {
    if (!isSignedIn) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/");
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
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void updateform(String value) {
    submitEnabled.value = emailValidator.isValid(emailController.text) &&
        passwordValidator.isValid(passwordController.text) &&
        !isLoading.value;
  }
}
