import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_todo/models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class AmplifyService {
  static configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    Amplify.addPlugins([authPlugin, datastorePlugin]);

    try {
      await Amplify.configure(amplifyconfig);
      print('Amplify Configured');
    } catch (e) {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
}
