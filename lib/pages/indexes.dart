import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/indextile.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/components/searchdelegate.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class IndexesPage extends StatelessWidget {
  const IndexesPage();

  void _goToAddIndexPage(BuildContext context) {
    Navigator.of(context).pushNamed('newindex');
  }

  Widget _indexListView(KuzzleIndexes kuzzleindexes) => AnimatedListView(
        itemCount: kuzzleindexes.indexMap.length,
        itemBuilder: (context, i) => IndexListTile(
          index: kuzzleindexes.indexMap.keys.elementAt(i),
        ),
      );

  void _onSearch(BuildContext context) {
    showSearch<String>(
      context: context,
      delegate: KuzzleSearchDelegate<String>(
        itemBuilder: (i) => IndexListTile(
          index: i,
        ),
        getSuggestions: (query) => StoreProvider.of<AppState>(context)
            .state
            .kuzzleindexes
            .indexMap
            .keys
            .where((element) =>
                element.toLowerCase().contains(query.trim().toLowerCase()))
            .toList(),
        getResults: (query) async => StoreProvider.of<AppState>(context)
            .state
            .kuzzleindexes
            .indexMap
            .keys
            .toList()
            .where((element) =>
                element.toLowerCase().contains(query.trim().toLowerCase()))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: 'Indexes',
        onSearch: () => _onSearch(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _goToAddIndexPage(context),
        ),
        body: StoreConnector<AppState, KuzzleIndexes>(
          onInit: (store) {
            if (store.state.kuzzleindexes.loadingState == KuzzleState.INIT ||
                store.state.kuzzleindexes.loadingState == KuzzleState.LOADED) {
              store.dispatch(getKuzzleIndexes);
            }
          },
          converter: (store) => store.state.kuzzleindexes,
          builder: (context, kuzzleindexes) =>
              kuzzleindexes.loadingState == KuzzleState.INIT
                  ? const Center(
                      child: Text('Initiating...'),
                    )
                  : (kuzzleindexes.loadingState == KuzzleState.LOADING &&
                          kuzzleindexes.indexMap.isEmpty
                      ? const LoadingAnimation()
                      : _indexListView(kuzzleindexes)),
        ),
      );
}
