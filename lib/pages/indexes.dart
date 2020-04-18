import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/components/searchdelegate.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum IndexListItemActions { DELETE, EDIT, BROWSECOLLECTIONS, CREATECOLLECTION }

class IndexesPage extends StatelessWidget {
  const IndexesPage();

  void _goToAddIndexPage(BuildContext context) {
    Navigator.of(context).pushNamed('newindex');
  }

  Widget _indexListView(KuzzleIndexes kuzzleindexes) => AnimatedListView(
        itemCount: kuzzleindexes.indexMap.length,
        itemBuilder: (context, i) => _IndexListTile(
          index: kuzzleindexes.indexMap.keys.elementAt(i),
        ),
      );

  void _onSearch(BuildContext context) {
    showSearch<String>(
      context: context,
      delegate: KuzzleSearchDelegate<String>(
        itemBuilder: (i) => _IndexListTile(
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

class _IndexListTile extends StatelessWidget {
  const _IndexListTile({@required this.index});
  final String index;

  Future<void> _deleteIndexConfirm(BuildContext context) async {
    final confirm = await confirmDialog(
        context, 'Delete $index', 'Are you sure you want to delete this index');
    if (confirm) {
      StoreProvider.of<AppState>(context).dispatch(deleteKuzzleIndex(index));
    }
  }

  void _goToAddCollectionPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewCollectionPage(
          index: index,
        ),
      ),
    );
  }

  void _goToCollectionsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionsPage(
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(index),
        onTap: () => _goToCollectionsPage(context),
        trailing: PopupMenuButton<IndexListItemActions>(
          onSelected: (action) {
            if (action == IndexListItemActions.BROWSECOLLECTIONS) {
              _goToCollectionsPage(context);
            } else if (action == IndexListItemActions.CREATECOLLECTION) {
              _goToAddCollectionPage(context);
            } else if (action == IndexListItemActions.EDIT) {
            } else if (action == IndexListItemActions.DELETE) {
              _deleteIndexConfirm(context);
            }
          },
          itemBuilder: (context) =>
              const <PopupMenuEntry<IndexListItemActions>>[
            PopupMenuItem(
              value: IndexListItemActions.CREATECOLLECTION,
              child: Text('Create Collection'),
            ),
            PopupMenuItem(
              value: IndexListItemActions.BROWSECOLLECTIONS,
              child: Text('Browse Collections'),
            ),
            PopupMenuItem(
              value: IndexListItemActions.EDIT,
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: IndexListItemActions.DELETE,
              child: Text('Delete'),
            ),
          ],
        ),
      );
}
