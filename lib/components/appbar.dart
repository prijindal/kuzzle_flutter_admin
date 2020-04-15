import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum AppBarActions { ADDENVIRONMENT, EXIT }

class KuzzleAppBar extends StatefulWidget implements PreferredSizeWidget {
  const KuzzleAppBar({
    this.subtitle,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  });

  final String subtitle;

  @override
  final Size preferredSize;

  @override
  _KuzzleAppBarState createState() => _KuzzleAppBarState();
}

class _KuzzleAppBarState extends State<KuzzleAppBar> {
  void _actionSelected(AppBarActions action) {
    if (action == AppBarActions.ADDENVIRONMENT) {
      Navigator.of(context).pushNamed('addenvironment');
    } else if (action == AppBarActions.EXIT) {
      FlutterKuzzle.instance.disconnect();
      exit(0);
    }
  }

  List<Widget> _getActions() => [
        PopupMenuButton<AppBarActions>(
          icon: const Icon(Icons.more_vert),
          onSelected: _actionSelected,
          itemBuilder: (context) => <PopupMenuEntry<AppBarActions>>[
            const PopupMenuItem<AppBarActions>(
              value: AppBarActions.ADDENVIRONMENT,
              child: Text('Add New Environment'),
            ),
            const PopupMenuItem<AppBarActions>(
              value: AppBarActions.EXIT,
              child: Text('Exit'),
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
              if (widget.subtitle != null)
                Visibility(
                  visible: true,
                  child: Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          actions: _getActions(),
        ),
      );
}
