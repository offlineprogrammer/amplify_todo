import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_todo/models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class AmplifyService {
  static configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    AmplifyStorageS3 storage = AmplifyStorageS3();
    Amplify.addPlugins([
      authPlugin,
      datastorePlugin,
      AmplifyAnalyticsPinpoint(),
      storage,
      AmplifyAPI()
    ]);

    try {
      await Amplify.configure(amplifyconfig);
      print('Amplify Configured');
    } catch (e) {
      print("Tried to reconfigure Amplify");
    }
  }
}
