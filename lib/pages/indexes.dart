import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/index.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class IndexesPage extends StatefulWidget {
  final Environment environment;
  IndexesPage({
    @required this.environment,
  });

  _IndexesPageState createState() => _IndexesPageState();
}

class _IndexesPageState extends State<IndexesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (StoreProvider.of<AppState>(context).state.kuzzleindexes.loadingState ==
        KuzzleState.INIT) {
      StoreProvider.of<AppState>(context).dispatch(getKuzzleIndexes);
    }
    super.didChangeDependencies();
  }

  Widget _indexListView(KuzzleIndexes kuzzleindexes) {
    return ListView(
      children: kuzzleindexes.indexMap.keys
          .map(
            (index) => ListTile(
              title: Text(index),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: KuzzleAppBar(
          environment: widget.environment,
          subtitle: "Indexes",
        ),
        body: StoreConnector<AppState, KuzzleIndexes>(
          converter: (store) => store.state.kuzzleindexes,
          builder: (context, kuzzleindexes) =>
              kuzzleindexes.loadingState == KuzzleState.INIT
                  ? Center(
                      child: Text('Initiating...'),
                    )
                  : (kuzzleindexes.loadingState == KuzzleState.LOADING
                      ? Center(
                          child: Text('Loading...'),
                        )
                      : _indexListView(kuzzleindexes)),
        ),
      );
}
