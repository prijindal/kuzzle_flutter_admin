import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum AppBarActions { ADDENVIRONMENT, EXIT, LOGOUT }

class KuzzleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KuzzleAppBar({
    this.subtitle,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  });

  final String subtitle;

  @override
  final Size preferredSize;

  Environments _environment(BuildContext context) =>
      StoreProvider.of<AppState>(context).state.environments;

  void _actionSelected(AppBarActions action, BuildContext context) {
    if (action == AppBarActions.ADDENVIRONMENT) {
      Navigator.of(context).pushNamed('addenvironment');
    } else if (action == AppBarActions.EXIT) {
      FlutterKuzzle.instance.disconnect();
      exit(0);
    } else if (action == AppBarActions.LOGOUT) {
      StoreProvider.of<AppState>(context).dispatch(
        EditEnvironmentAction(
          _environment(context).defaultEnvironment,
          Environment(
            name: _environment(context).defaultEnvironment,
            token: '',
          ),
        ),
      );
      StoreProvider.of<AppState>(context).dispatch(logoutUser());
    }
  }

  List<Widget> _getActions(BuildContext context) => [
        PopupMenuButton<AppBarActions>(
          icon: const Icon(Icons.more_vert),
          onSelected: (action) => _actionSelected(action, context),
          itemBuilder: (context) => <PopupMenuEntry<AppBarActions>>[
            const PopupMenuItem<AppBarActions>(
              value: AppBarActions.ADDENVIRONMENT,
              child: Text('Add New Environment'),
            ),
            const PopupMenuItem<AppBarActions>(
              value: AppBarActions.EXIT,
              child: Text('Exit'),
            ),
            const PopupMenuItem<AppBarActions>(
              value: AppBarActions.LOGOUT,
              child: Text('Logout'),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, Environment>(
        converter: (store) => store.state.environments.getDefaultEnvironment,
        builder: (context, environment) => AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                environment.name,
              ),
              if (subtitle != null)
                Visibility(
                  visible: true,
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          actions: _getActions(context),
        ),
      );
}
