import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/events.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<dynamic> checkAuth(String jwt) => (store) async {
      store.dispatch(LoginKuzzleAuthAction());
      if (initKuzzleIndex()) {
        try {
          final result = await FlutterKuzzle.instance.auth.checkToken(jwt);
          if (result['valid'] == false) {
            throw Error();
          }
          FlutterKuzzle.instance.jwt = jwt;
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

ThunkAction<dynamic> loginUser(
        String strategy, Map<String, dynamic> credentials,
        {bool remember = false, Environment environment}) =>
    (store) async {
      store.dispatch(LoginKuzzleAuthAction());
      if (initKuzzleIndex()) {
        try {
          final jwt =
              await FlutterKuzzle.instance.auth.login(strategy, credentials);
          if (remember == true && environment != null) {
            store.dispatch(
              EditEnvironmentAction(
                environment.name,
                Environment(name: environment.name, token: jwt),
              ),
            );
          }
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

ThunkAction<dynamic> logoutUser() => (store) async {
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

ThunkAction<dynamic> checkAdminExists() => (store) async {
      store.dispatch(AdminCheckKuzzleAuthAction());
      if (initKuzzleIndex()) {
        try {
          final result = await FlutterKuzzle.instance.server.adminExists();
          store.dispatch(AdminCheckSuccessKuzzleAuthAction(result));
        } catch (e) {
          store.dispatch(AdminCheckErroredKuzzleAuthAction(e.toString()));
        }
      }
    };
