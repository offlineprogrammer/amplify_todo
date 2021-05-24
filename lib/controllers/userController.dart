import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_todo/models/Users.dart';
import 'package:amplify_todo/services/auth_service.dart';
import 'package:amplify_todo/services/datastore_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController to = Get.find();
  DataStoreService _datastoreService = DataStoreService();
  AuthService _authService = AuthService();
  final currentUser = Users().obs;

  Users get user => currentUser.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getCurrUser();
    super.onReady();
  }

  Future<void> getCurrUser() async {
    AuthUser authUser = await _authService.getCurrentUser();
    currentUser.value = await _datastoreService.getUser(authUser.userId);
    print(currentUser.value);
  }
}
