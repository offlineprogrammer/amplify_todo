import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_todo/models/Todo.dart';
import 'package:amplify_todo/models/Users.dart';

class DataStoreService {
  Future<void> saveUser(Users user) async {
    try {
      if (await getUser(user.id) == null) {
        await Amplify.DataStore.save(user);
        print('Saved');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<Users> getUser(String userId) async {
    try {
      List<Users> user = await Amplify.DataStore.query(Users.classType,
          where: Users.ID.eq(userId));
      if (user.length > 0) {
        return user.first;
      } else
        print('null');
      return null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Todo>> getTodos(String userId) async {
    try {
      List<Todo> todos = await Amplify.DataStore.query(Todo.classType,
          where: Todo.USERID.eq(userId));
      if (todos.length > 0) {
        return todos;
      } else
        return null;
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeTodo(Todo todo) async {
    try {
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      print('error');
      throw e;
    }
  }

  Future<void> saveTodo(Todo todo) async {
    try {
      await Amplify.DataStore.save(todo);
    } catch (e) {
      throw e;
    }
  }

  Future<void> setToDoDone(Todo todo, bool newValue) async {
    try {
      Todo todoData = (await Amplify.DataStore.query(Todo.classType,
          where: Todo.ID.eq(todo.id)))[0];
      await Amplify.DataStore.save(todoData.copyWith(isDone: newValue));
    } catch (e) {
      throw e;
    }
  }
}
