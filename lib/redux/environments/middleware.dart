import 'package:kuzzleflutteradmin/redux/environments/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import 'package:redux/redux.dart';

import 'events.dart';

dynamic saveMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action is AddEnvironmentAction ||
      action is RemoveEnvironmentAction ||
      action is SetDefaultEnvironmentAction ||
      action is SetFirstEnvironmentAction) {
    syncEnvironments(
      store.state.environments.environments,
      store.state.environments.defaultEnvironment,
    );
  }
}
