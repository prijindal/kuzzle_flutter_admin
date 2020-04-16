import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/kuzzleauth.dart';
import 'package:kuzzleflutteradmin/models/kuzzleping.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/indexes.dart';
import 'package:kuzzleflutteradmin/pages/loading.dart';
import 'package:kuzzleflutteradmin/pages/login.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleping/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class EnvironmentHomePage extends StatelessWidget {
  const EnvironmentHomePage(this.environment);
  final Environment environment;

  String _getMessage(KuzzlePing kuzzleping) {
    if (kuzzleping.errorMessage != null) {
      return kuzzleping.errorMessage;
    }
    if (kuzzleping.loadingState == KuzzleState.INIT) {
      return 'Initiating';
    } else if (kuzzleping.loadingState == KuzzleState.LOADING) {
      return 'Trying to connect';
    } else {
      return 'Some unknown error Occurred';
    }
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, KuzzlePing>(
        onInit: (store) {
          FlutterKuzzle.instance = FlutterKuzzle(
            WebSocketProtocol(
              environment.host,
              port: environment.port,
              ssl: environment.ssl,
            ),
          );
          if (store.state.kuzzleping.loadingState != KuzzleState.LOADING) {
            store.dispatch(SetDefaultEnvironmentAction(environment.name));
            store.dispatch(initKuzzlePing);
          }
        },
        converter: (store) => store.state.kuzzleping,
        builder: (context, kuzzleping) => kuzzleping.loadingState !=
                KuzzleState.LOADED
            ? Scaffold(
                appBar: const KuzzleAppBar(),
                body: AnimatedColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Text(_getMessage(kuzzleping)),
                    ),
                    if (kuzzleping.loadingState == KuzzleState.INIT ||
                        kuzzleping.loadingState == KuzzleState.LOADING)
                      const LoadingAnimation()
                  ],
                ),
              )
            : StoreConnector<AppState, String>(
                onInitialBuild: (jwt) {
                  if (jwt.isNotEmpty) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(checkAuth(jwt));
                  }
                },
                converter: (store) => store
                    .state.environments.environments[environment.name].token,
                builder: (store, jwt) => StoreConnector<AppState, KuzzleAuth>(
                  converter: (store) => store.state.kuzzleauth,
                  builder: (context, kuzzleauth) => !kuzzleauth.isAuthenticated
                      ? ((kuzzleauth.loginState == KuzzleState.LOADING &&
                              jwt.isNotEmpty)
                          ? const LoadingPage()
                          : LoginPage())
                      : IndexesPage(),
                ),
              ),
      );
}
