import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/kuzzleauth.dart';
import 'package:kuzzleflutteradmin/models/kuzzleping.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/createadmin.dart';
import 'package:kuzzleflutteradmin/pages/indexes.dart';
import 'package:kuzzleflutteradmin/pages/login.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleping/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class EnvironmentHomePageRouteArguments {
  EnvironmentHomePageRouteArguments({@required this.environment});
  final Environment environment;
}

class EnvironmentHomeRoutePage extends StatelessWidget {
  const EnvironmentHomeRoutePage();

  @override
  Widget build(BuildContext context) => EnvironmentHomePage(
        (ModalRoute.of(context).settings.arguments
                as EnvironmentHomePageRouteArguments)
            .environment,
      );
}

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
          if (FlutterKuzzle.instance != null) {
            FlutterKuzzle.instance.disconnect();
          }
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
            ? HomeLoadingPage(
                message: _getMessage(kuzzleping),
                isLoading: kuzzleping.loadingState == KuzzleState.INIT ||
                    kuzzleping.loadingState == KuzzleState.LOADING,
              )
            : StoreConnector<AppState, Environment>(
                onInit: (store) {
                  store.dispatch(InitKuzzleAuthAction());
                },
                onInitialBuild: (environment) {
                  if (environment.token != null &&
                      environment.token.isNotEmpty) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(checkAuth(environment.token));
                  }
                },
                converter: (store) =>
                    store.state.environments.environments[environment.name],
                builder: (store, environment) =>
                    StoreConnector<AppState, KuzzleAuth>(
                  converter: (store) => store.state.kuzzleauth,
                  builder: (context, kuzzleauth) => !kuzzleauth.isAuthenticated
                      ? ((kuzzleauth.loginState == KuzzleState.LOADING &&
                              environment != null &&
                              environment.token != null &&
                              environment.token.isNotEmpty)
                          ? const HomeLoadingPage(
                              message: 'Checking Authentication',
                              isLoading: true,
                            )
                          : const LoginCheck())
                      : const IndexesPage(),
                ),
              ),
      );
}

class LoginCheck extends StatelessWidget {
  const LoginCheck();

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, KuzzleAuth>(
        onInit: (store) {
          store.dispatch(checkAdminExists());
        },
        converter: (store) => store.state.kuzzleauth,
        builder: (context, kuzzleauth) =>
            kuzzleauth.adminCheckState == KuzzleState.LOADING
                ? const HomeLoadingPage(
                    isLoading: true,
                    message: 'Checking Authentication',
                  )
                : kuzzleauth.adminCheckResult == false
                    ? const CreateAdminPage()
                    : const LoginPage(),
      );
}

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({
    @required this.message,
    @required this.isLoading,
  });

  final String message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const KuzzleAppBar(
          key: Key('Home App Bar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Text(message),
            ),
            if (isLoading) const LoadingAnimation(),
          ],
        ),
      );
}
