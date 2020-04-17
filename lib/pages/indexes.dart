import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum IndexListItemActions { DELETE, EDIT, BROWSECOLLECTIONS, CREATECOLLECTION }

class IndexesPage extends StatefulWidget {
  @override
  _IndexesPageState createState() => _IndexesPageState();
}

class _IndexesPageState extends State<IndexesPage> {
  void _goToAddIndexPage() {
    Navigator.of(context).pushNamed('newindex');
  }

  Widget _indexListView(KuzzleIndexes kuzzleindexes) => AnimatedListView(
        itemCount: kuzzleindexes.indexMap.length,
        itemBuilder: (context, i) => _IndexListTile(
          index: kuzzleindexes.indexMap.keys.elementAt(i),
        ),
      );

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: 'Indexes',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _goToAddIndexPage,
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

class _IndexListTile extends StatefulWidget {
  const _IndexListTile({@required this.index});
  final String index;

  @override
  _IndexListTileState createState() => _IndexListTileState();
}

class _IndexListTileState extends State<_IndexListTile> {
  Future<void> _deleteIndexConfirm() async {
    final confirm = await confirmDialog(context, 'Delete $widget.index',
        'Are you sure you want to delete this index');
    if (confirm) {
      StoreProvider.of<AppState>(context)
          .dispatch(deleteKuzzleIndex(widget.index));
    }
  }

  void _goToAddCollectionPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewCollectionPage(
          index: widget.index,
        ),
      ),
    );
  }

  void _goToCollectionsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionsPage(
          index: widget.index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(widget.index),
        onTap: _goToCollectionsPage,
        trailing: PopupMenuButton<IndexListItemActions>(
          onSelected: (action) {
            if (action == IndexListItemActions.BROWSECOLLECTIONS) {
              _goToCollectionsPage();
            } else if (action == IndexListItemActions.CREATECOLLECTION) {
              _goToAddCollectionPage();
            } else if (action == IndexListItemActions.EDIT) {
            } else if (action == IndexListItemActions.DELETE) {
              _deleteIndexConfirm();
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
