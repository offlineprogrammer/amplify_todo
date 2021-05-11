import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_todo/models/Users.dart';
import 'package:amplify_todo/services.dart/auth.service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  RxBool isSignedIn = false.obs;
  AuthService _authService;
  Rx<Users> currentUser = null.obs;

  //String get user => currentUser?.value?.email;

  AuthController() {
    _authService = AuthService();
  }

  void change() => isSignedIn.value = !isSignedIn.value;

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
}
