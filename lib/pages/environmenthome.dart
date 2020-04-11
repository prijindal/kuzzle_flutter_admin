import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/indexes.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleping/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleping/state.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class EnvironmentHomePage extends StatefulWidget {
  final Environment environment;
  EnvironmentHomePage(this.environment);

  _EnvironmentHomePageState createState() => _EnvironmentHomePageState();
}

class _EnvironmentHomePageState extends State<EnvironmentHomePage> {
  @override
  void initState() {
    FlutterKuzzle.instance = FlutterKuzzle(
      WebSocketProtocol(
        widget.environment.host,
        port: widget.environment.port,
        ssl: widget.environment.ssl,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (StoreProvider.of<AppState>(context).state.kuzzleping.loadingState ==
        KuzzleState.INIT) {
      StoreProvider.of<AppState>(context).dispatch(initKuzzlePing);
    }
    super.didChangeDependencies();
  }

  String _getMessage(KuzzlePing kuzzleping) {
    if (kuzzleping.errorMessage != null) {
      return kuzzleping.errorMessage;
    }
    if (kuzzleping.loadingState == KuzzleState.INIT) {
      return "Initiating";
    } else if (kuzzleping.loadingState == KuzzleState.LOADING) {
      return 'Trying to connect';
    } else {
      return "Some unknown error Occurred";
    }
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, KuzzlePing>(
        converter: (store) => store.state.kuzzleping,
        builder: (context, kuzzleping) =>
            kuzzleping.loadingState != KuzzleState.LOADED
                ? Scaffold(
                    appBar: KuzzleAppBar(
                      environment: widget.environment,
                    ),
                    body: Center(
                      child: Text(_getMessage(kuzzleping)),
                    ),
                  )
                : IndexesPage(
                    environment: widget.environment,
                  ),
      );
}
