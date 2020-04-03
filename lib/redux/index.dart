import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'environments/index.dart';

@immutable
class AppState {
  final Environments environments;
  AppState({
    Environments environments,
  }) : this.environments = environments ?? Environments();
}

AppState appReducer(AppState state, action) {
  return AppState(
    environments: environmentsReducer(state.environments, action),
  );
}

dynamic saveMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  store.dispatch(syncEnvironments(store.state.environments.environments,
      store.state.environments.defaultEnvironment));
}

Store<AppState> initStore() {
  final store = new Store<AppState>(
    appReducer,
    middleware: [thunkMiddleware, saveMiddleware],
    initialState: AppState(),
  );
  return store;
}

final store = initStore();
