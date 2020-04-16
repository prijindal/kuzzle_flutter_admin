import 'package:kuzzleflutteradmin/helpers/shared_preferences.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:redux/redux.dart';
import 'events.dart';

const ENVIRONMENTS_KEY = 'environments';
const DEFAULT_ENVIRONMENT_KEY = 'default_environment';

Future<void> initEnvironments(Store<dynamic> store) async {
  store.dispatch(InitializeEnvironmentAction());
  final environmentsJson =
      await FlutterSharedPreferences.getInstance().getJson(ENVIRONMENTS_KEY);
  final defaultEnvironment = await FlutterSharedPreferences.getInstance()
      .getString(DEFAULT_ENVIRONMENT_KEY);
  final environments = <String, Environment>{};
  if (environmentsJson != null) {
    for (var key in environmentsJson.keys) {
      final environmentJson = environmentsJson[key] as Map<String, dynamic>;
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

Future<void> syncEnvironments(
    Map<String, dynamic> environments, String defaultEnvironment) async {
  if (environments != null && environments.isNotEmpty) {
    final environmentsJson = <String, dynamic>{};
    environments.forEach((key, value) {
      environmentsJson[key] = value.toJson();
    });
    await FlutterSharedPreferences.getInstance()
        .setJson(ENVIRONMENTS_KEY, environmentsJson);
  }
  if (defaultEnvironment != null && defaultEnvironment.isNotEmpty) {
    await FlutterSharedPreferences.getInstance()
        .setString(DEFAULT_ENVIRONMENT_KEY, defaultEnvironment);
  }
}
