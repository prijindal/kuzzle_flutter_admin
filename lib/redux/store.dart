import 'package:kuzzleflutteradmin/redux/environments/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'state.dart';
import 'reducer.dart';

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
