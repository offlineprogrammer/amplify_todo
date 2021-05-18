import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:get/get.dart';

class ControllersBindings extends Bindings {
  @override
  void dependencies() {
    //  Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<TodoController>(() => TodoController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
