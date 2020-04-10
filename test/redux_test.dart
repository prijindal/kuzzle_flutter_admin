// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:kuzzle/kuzzle.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
// import 'package:kuzzleflutteradmin/redux/index.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/index.dart';

void main() async {
  FlutterKuzzle.instance = FlutterKuzzle(
    WebSocketProtocol(
      '192.168.146.136',
    ),
  );
  final store = new Store<KuzzleIndexes>(
    (state, action) => kuzzleReducer(state, action),
    middleware: [
      thunkMiddleware,
      new LoggingMiddleware.printer(),
    ],
    initialState: KuzzleIndexes(),
  );
  await FlutterKuzzle.instance.connect();
  store.dispatch(getKuzzleIndexes);
  Timer.periodic(Duration(milliseconds: 10), (timer) {
    if (store.state.loadingState == KuzzleState.LOADED &&
        store.state.getIndexes().length > 0) {
      var index = store.state.getIndexes()[0];
      store.dispatch(getKuzzleCollections(index));
      timer.cancel();
    }
  });
}
