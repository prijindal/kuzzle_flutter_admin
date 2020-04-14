import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/events.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<dynamic> loginUser(
    String strategy, Map<String, dynamic> credentials) {
  return (Store<dynamic> store) async {
    store.dispatch(LoginKuzzleAuthAction());
    if (initKuzzleIndex()) {
      try {
        var jwt =
            await FlutterKuzzle.instance.auth.login(strategy, credentials);
        store.dispatch(
          LoginSuccessKuzzleAuthAction(jwt),
        );
      } catch (e) {
        store.dispatch(
          LoginErroredKuzzleAuthAction(e.toString()),
        );
      }
    }
  };
}

ThunkAction<dynamic> logoutUser() {
  return (Store<dynamic> store) async {
    store.dispatch(LogoutKuzzleAuthAction());
    if (initKuzzleIndex()) {
      try {
        await FlutterKuzzle.instance.auth.logout();
        store.dispatch(LogoutSuccessKuzzleAuthAction());
      } catch (e) {
        store.dispatch(LogoutErroredKuzzleAuthAction(e.toString()));
      }
    }
  };
}
