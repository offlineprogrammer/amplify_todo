import 'package:amplify_todo/controllers/authController.dart';
import 'package:get/get.dart';

class ControllersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
