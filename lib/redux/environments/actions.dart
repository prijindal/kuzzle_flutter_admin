import 'package:kuzzleflutteradmin/helpers/shared_preferences.dart';
import 'package:kuzzleflutteradmin/kuzzle/models/environment.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'events.dart';

const ENVIRONMENTS_KEY = "environments";
const DEFAULT_ENVIRONMENT_KEY = "default_environment";

void initEnvironments(Store<dynamic> store) async {
  var environmentsJson =
      await FlutterSharedPreferences.getInstance().getJson(ENVIRONMENTS_KEY);
  var defaultEnvironment = await FlutterSharedPreferences.getInstance()
      .getString(DEFAULT_ENVIRONMENT_KEY);
  var environments = <String, Environment>{};
  if (environmentsJson != null) {
    environmentsJson.forEach((key, environmentJson) {
      environments[key] = Environment.fromJson(environmentJson);
    });
  }
  print('Loading environment variables');
  store.dispatch(
    InitializeSuccessEnvironmentAction(
      environments,
      defaultEnvironment,
    ),
  );
}

ThunkAction<dynamic> syncEnvironments(
    Map<String, dynamic> environments, String defaultEnvironment) {
  return (Store<dynamic> store) async {
    Map<String, dynamic> environmentsJson = {};
    environments.forEach((key, value) {
      environmentsJson[key] = value.toJson();
    });
    await FlutterSharedPreferences.getInstance()
        .setJson(ENVIRONMENTS_KEY, environmentsJson);
    await FlutterSharedPreferences.getInstance()
        .setString(DEFAULT_ENVIRONMENT_KEY, defaultEnvironment);
  };
}
