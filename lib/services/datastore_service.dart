import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_todo/models/Todo.dart';
import 'package:amplify_todo/models/Users.dart';

class DataStoreService {
  Future<void> saveUser(Users user) async {
    try {
      await Amplify.DataStore.save(user);
      print('User Saved');
    } catch (e) {
      throw e;
    }
  }

  Future<Users> getUser(String userId) async {
    try {
      List<Users> user = await Amplify.DataStore.query(Users.classType,
          where: Users.ID.eq(userId));
      if (user.length > 0) {
        print(user.first);
        return user.first;
      } else
        return null;
    } catch (e) {
      throw e;
    }
  }

  // Stream<List<TodoModel>> todoStream(String uid) {
  //   return _firestore
  //       .collection("users")
  //       .document(uid)
  //       .collection("todos")
  //       .orderBy("dateCreated", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<TodoModel> retVal = List();
  //     query.documents.forEach((element) {
  //       retVal.add(TodoModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }

  Future<List<Todo>> getTodos(String userId) async {
    try {
      print('datastore gettodos');
      List<Todo> todos = await Amplify.DataStore.query(Todo.classType,
          where: Todo.USERID.eq(userId));
      if (todos.length > 0) {
        print(todos);
        return todos;
      } else
        return null;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveTodo(Todo todo) async {
    try {
      await Amplify.DataStore.save(todo);
      print('todo Saved');
    } catch (e) {
      throw e;
    }
  }
}
