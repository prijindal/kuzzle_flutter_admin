import 'package:kuzzleflutteradmin/redux/environments/middleware.dart';
import 'package:redux/redux.dart';
// import 'package:redux_logging/redux_logging.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'reducer.dart';
import 'state.dart';

Store<AppState> initStore() {
  final remoteDevtools = RemoteDevToolsMiddleware('localhost:8000');
  final store = Store<AppState>(
    appReducer,
    middleware: [
      remoteDevtools,
      thunkMiddleware,
      saveMiddleware,
      // LoggingMiddleware.printer(),
    ],
    initialState: const AppState(),
  );
  remoteDevtools.store = store;
  remoteDevtools.connect();
  return store;
}
