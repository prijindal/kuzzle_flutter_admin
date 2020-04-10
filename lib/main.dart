import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/redux/environments/index.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import 'package:kuzzleflutteradmin/redux/store.dart';
import 'helpers/navigation.dart';
import 'pages/loading.dart';
import 'pages/environments.dart';
import 'pages/environmenthome.dart';
import 'pages/addenvironment.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final store = initStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Kuzzle Admin',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => StoreConnector<AppState, Environments>(
                converter: (store) => store.state.environments,
                builder: (context, environments) => !environments.isInitialized
                    ? LoadingPage()
                    : (environments.environments.length == 0
                        ? AddEnvironmentPage()
                        : (environments.getDefaultEnvironment != null
                            ? EnvironmentHomePage(
                                environments.getDefaultEnvironment,
                              )
                            : EnvironmentsPage())),
              ),
          'addenvironment': (context) => AddEnvironmentPage(),
        },
      ),
    );
  }
}
