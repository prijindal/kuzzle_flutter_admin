import 'state.dart';
import 'events.dart';

Environments environmentsReducer(Environments state, EnvironmentAction action) {
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
    );
  } else if (action is AddEnvironmentAction) {
    var environments = state.environments;
    environments[action.environment.name] = action.environment;
    return state.copyWith(
      environments: environments,
    );
  } else if (action is RemoveEnvironmentAction) {
    var environments = state.environments;
    environments.remove(action.environmentName);
    return state.copyWith(
      environments: environments,
    );
  } else if (action is SetDefaultEnvironmentAction) {
    return state.copyWith(
      defaultEnvironment: action.environmentName,
    );
  } else if (action is SetFirstEnvironmentAction) {
    var environments = state.environments;
    environments[action.environment.name] = action.environment;
    return state.copyWith(
      environments: environments,
      defaultEnvironment: action.environment.name,
    );
  }
  return state;
}
