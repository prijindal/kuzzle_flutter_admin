import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/redux/environments/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, Environments>(
        onInit: (store) {
          if (store.state.environments.isInitialized == false) {
            store.dispatch(initEnvironments);
          }
        },
        converter: (store) => store.state.environments,
        builder: (context, environments) => const Scaffold(
          body: LoadingAnimation(),
        ),
      );
}
