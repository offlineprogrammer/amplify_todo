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
  final TextEditingController todoTitleController = TextEditingController();

  List<Todo> todoList = <Todo>[].obs;

  @override
  void onReady() {
    getTodos();
    super.onReady();
  }

  Future<void> getTodos() async {
    AuthUser _authUser = await _authService.getCurrentUser();
    List<Todo> _list = await _datastoreService.getTodos(_authUser.userId);
    todoList.addAllIf(_list != null, _list);
  }

  Future<void> addTodo() async {
    AuthUser _authUser = await _authService.getCurrentUser();
    Todo todo = new Todo(
        name: todoTitleController.text.toString(),
        isDone: false,
        createdAt: TemporalTimestamp.now(),
        updatedAt: TemporalTimestamp.now(),
        userId: _authUser.userId);
    await _datastoreService.saveTodo(todo);
    todoList.add(todo);
  }

  Future<void> removeTodo(Todo todo) async {
    await _datastoreService.removeTodo(todo);
    todoList.remove(todo);
  }

  Future<void> setToDoDone(Todo todo, bool newValue) async {
    await _datastoreService.setToDoDone(todo, newValue);
    todoList[todoList.indexWhere((element) => element.id == todo.id)] =
        todo.copyWith(isDone: newValue);
  }
}
