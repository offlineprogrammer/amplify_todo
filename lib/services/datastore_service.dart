import 'package:amplify_flutter/amplify.dart';
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
}
