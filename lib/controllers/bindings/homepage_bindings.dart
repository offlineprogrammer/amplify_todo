import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    //Get.lazyPut<AuthController>(() => AuthController());
    Get.put<TodoController>(TodoController(), permanent: true);
    //Get.lazyPut<TodoController>(() => TodoController());
    Get.put<UserController>(UserController(), permanent: true);
    //Get.lazyPut<UserController>(() => UserController());
  }
}
