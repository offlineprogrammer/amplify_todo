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
}
