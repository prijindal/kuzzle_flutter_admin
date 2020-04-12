import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import 'package:kuzzleflutteradmin/redux/environments/index.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (StoreProvider.of<AppState>(context).state.environments.isInitialized ==
        false) {
      StoreProvider.of<AppState>(context).dispatch(initEnvironments);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text("Loading..."),
        ),
      );
}