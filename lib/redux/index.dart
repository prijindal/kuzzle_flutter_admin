import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'environments/index.dart';
import 'kuzzleindex/index.dart';

@immutable
class AppState {
  final Environments environments;
  final KuzzleIndexes kuzzleindexes;
  AppState({
    Environments environments,
    KuzzleIndexes kuzzleindexes,
  })  : this.environments = environments ?? Environments(),
        this.kuzzleindexes = kuzzleindexes ?? KuzzleIndexes();
}

AppState appReducer(AppState state, action) {
  return AppState(
    environments: environmentsReducer(state.environments, action),
    kuzzleindexes: kuzzleReducer(state.kuzzleindexes, action),
  );
}

dynamic saveMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  store.dispatch(
    syncEnvironments(
      store.state.environments.environments,
      store.state.environments.defaultEnvironment,
    ),
  );
}

Store<AppState> initStore() {
  final store = new Store<AppState>(
    appReducer,
    middleware: [
      thunkMiddleware,
      saveMiddleware,
      new LoggingMiddleware.printer(),
    ],
    initialState: AppState(),
  );
  return store;
}

final store = initStore();
