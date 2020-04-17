import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/indexes.dart';
import 'package:kuzzleflutteradmin/pages/newindex.dart';
import 'package:kuzzleflutteradmin/pages/newuser.dart';
import 'package:kuzzleflutteradmin/pages/users.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import 'package:kuzzleflutteradmin/redux/store.dart';
import 'package:redux/redux.dart';
import 'helpers/navigation.dart';
import 'pages/addenvironment.dart';
import 'pages/environmenthome.dart';
import 'pages/environments.dart';
import 'pages/loading.dart';

const int _kuzzleMaterialPrimaryValue = 0xFF002835;

const MaterialColor _kuzzleMaterialColor = MaterialColor(
  _kuzzleMaterialPrimaryValue,
  <int, Color>{
    50: Color(0xFFe0e5e7),
    100: Color(0xFFb3bfc2),
    200: Color(0xFF80949a),
    300: Color(0xFF4d6972),
    400: Color(0xFF264853),
    500: Color(_kuzzleMaterialPrimaryValue),
    600: Color(0xFF002430),
    700: Color(0xFF001e28),
    800: Color(0xFF001822),
    900: Color(0xFF000f16),
  },
);

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store = initStore();

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Kuzzle Admin',
          theme: ThemeData(
            primarySwatch: _kuzzleMaterialColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            '/': (context) => StoreConnector<AppState, Environments>(
                  converter: (store) => store.state.environments,
                  builder: (context, environments) =>
                      !environments.isInitialized
                          ? const LoadingPage()
                          : (environments.environments.isEmpty
                              ? AddEnvironmentPage()
                              : (environments.getDefaultEnvironment != null
                                  ? EnvironmentHomePage(
                                      environments.getDefaultEnvironment,
                                    )
                                  : const EnvironmentsPage())),
                ),
            'environment': (context) => EnvironmentHomeRoutePage(),
            'addenvironment': (context) => AddEnvironmentPage(),
            'indexes': (context) => IndexesPage(),
            'newindex': (context) => NewIndexPage(),
            'collections': (context) => CollectionsPageRoute(),
            'users': (context) => UsersPage(),
            'newuser': (context) => NewUserPage(),
          },
        ),
      );
}
