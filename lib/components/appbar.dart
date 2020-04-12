import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum AppBarActions { ADDENVIRONMENT }

class KuzzleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String subtitle;

  KuzzleAppBar({
    this.subtitle,
  });

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  _KuzzleAppBarState createState() => _KuzzleAppBarState();
}

class _KuzzleAppBarState extends State<KuzzleAppBar> {
  void _actionSelected(AppBarActions action) {
    if (action == AppBarActions.ADDENVIRONMENT) {
      Navigator.of(context).pushNamed("addenvironment");
    }
  }

  List<Widget> _getActions() {
    return [
      PopupMenuButton<AppBarActions>(
        icon: Icon(Icons.more_vert),
        onSelected: _actionSelected,
        itemBuilder: (context) => <PopupMenuEntry<AppBarActions>>[
          const PopupMenuItem<AppBarActions>(
            value: AppBarActions.ADDENVIRONMENT,
            child: Text("Add New Environment"),
          ),
        ],
      ),
    ];
  }

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
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
            ],
          ),
          actions: _getActions(),
        ),
      );
}