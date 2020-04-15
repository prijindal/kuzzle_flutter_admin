import 'package:kuzzleflutteradmin/helpers/shared_preferences.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'events.dart';

const ENVIRONMENTS_KEY = 'environments';
const DEFAULT_ENVIRONMENT_KEY = 'default_environment';

void initEnvironments(Store<dynamic> store) async {
  store.dispatch(InitializeEnvironmentAction());
  var environmentsJson =
      await FlutterSharedPreferences.getInstance().getJson(ENVIRONMENTS_KEY);
  var defaultEnvironment = await FlutterSharedPreferences.getInstance()
      .getString(DEFAULT_ENVIRONMENT_KEY);
  var environments = <String, Environment>{};
  if (environmentsJson != null) {
    for (var key in environmentsJson.keys) {
      Map<String, dynamic> environmentJson =
          environmentsJson[key] as Map<String, dynamic>;
      environments[key] = Environment.fromJson(environmentJson);
    }
  }
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
    if (environments != null && environments.length > 0) {
      Map<String, dynamic> environmentsJson = {};
      environments.forEach((key, value) {
        environmentsJson[key] = value.toJson();
      });
      await FlutterSharedPreferences.getInstance()
          .setJson(ENVIRONMENTS_KEY, environmentsJson);
    }
    if (defaultEnvironment != null && defaultEnvironment.length > 0) {
      await FlutterSharedPreferences.getInstance()
          .setString(DEFAULT_ENVIRONMENT_KEY, defaultEnvironment);
    }
  };
}
