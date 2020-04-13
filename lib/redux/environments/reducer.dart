import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/environments.dart';

import 'events.dart';

Environments environmentsReducer(Environments state, action) {
  if (state == null) {
    state = Environments(
      isInitialized: false,
    );
  }
  if (action is InitializeEnvironmentAction) {
    return state.copyWith(
      isInitialized: false,
    );
  } else if (action is InitializeSuccessEnvironmentAction) {
    return state.copyWith(
      isInitialized: true,
      environments: action.environments,
      defaultEnvironment: action.defaultEnvironments,
    );
  } else if (action is AddEnvironmentAction) {
    Map<String, Environment> environments = <String, Environment>{};
    environments.addAll(state.environments);
    environments[action.environment.name] = action.environment;
    return state.copyWith(
      environments: environments,
    );
  } else if (action is RemoveEnvironmentAction) {
    Map<String, Environment> environments = <String, Environment>{};
    environments.addAll(state.environments);
    environments.remove(action.environmentName);
    return state.copyWith(
      environments: environments,
    );
  } else if (action is SetDefaultEnvironmentAction) {
    return state.copyWith(
      defaultEnvironment: action.environmentName,
    );
  } else if (action is SetFirstEnvironmentAction) {
    Map<String, Environment> environments = <String, Environment>{};
    environments.addAll(state.environments);
    environments[action.environment.name] = action.environment;
    return state.copyWith(
      environments: environments,
      defaultEnvironment: action.environment.name,
    );
  }
  return state;
}
