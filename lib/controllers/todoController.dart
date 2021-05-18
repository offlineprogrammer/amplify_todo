import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_todo/models/ModelProvider.dart';
import 'package:amplify_todo/models/Todo.dart';
import 'package:amplify_todo/services/auth_service.dart';
import 'package:amplify_todo/services/datastore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  DataStoreService _datastoreService = DataStoreService();
  AuthService _authService = AuthService();
  final TextEditingController todovalueController = TextEditingController();
  //Rx<List<Todo>> todoList = Rx<List<Todo>>([]);
  List<Todo> todoList = <Todo>[].obs;

  @override
  void onReady() {
    // called after the widget is rendered on screen
    print('ToDO Ready');
    getTodos();
    super.onReady();
  }

  Future<void> getTodos() async {
    AuthUser authUser = await _authService.getCurrentUser();
    todoList.addAll(await _datastoreService.getTodos(authUser.userId));
  }

  Future<void> addTodo() async {
    print(todovalueController.text);
    AuthUser authUser = await _authService.getCurrentUser();
    Todo todo = new Todo(
        name: todovalueController.text.toString(),
        status: TodoStatus.NEW,
        createdAt: TemporalTimestamp.now(),
        updatedAt: TemporalTimestamp.now(),
        // description: todoController.text,
        userId: authUser.userId);
    print(todo.toString());
    await _datastoreService.saveTodo(todo);
    print(todoList.length);
    todoList.add(todo);

    print(todoList.length);
  }
}
