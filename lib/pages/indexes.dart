import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/index.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum IndexListItemActions { DELETE, EDIT, BROWSECOLLECTIONS, CREATECOLLECTION }

class IndexesPage extends StatefulWidget {
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

  void _goToAddIndexPage() {
    Navigator.of(context).pushNamed("newindex");
  }

  Widget _indexListView(KuzzleIndexes kuzzleindexes) {
    return ListView(
      children: kuzzleindexes.indexMap.keys
          .map(
            (index) => _IndexListTile(
              index: index,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: "Indexes",
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _goToAddIndexPage,
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

class _IndexListTile extends StatefulWidget {
  final String index;
  _IndexListTile({@required this.index});

  _IndexListTileState createState() => _IndexListTileState();
}

class _IndexListTileState extends State<_IndexListTile> {
  void _deleteIndexConfirm() async {
    var confirm = await confirmDialog(context, "Delete $widget.index",
        "Are you sure you want to delete this index");
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

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(widget.index),
        trailing: PopupMenuButton<IndexListItemActions>(
          onSelected: (action) {
            if (action == IndexListItemActions.BROWSECOLLECTIONS) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CollectionsPage(
                    index: widget.index,
                  ),
                ),
              );
            } else if (action == IndexListItemActions.CREATECOLLECTION) {
              _goToAddCollectionPage();
            } else if (action == IndexListItemActions.EDIT) {
            } else if (action == IndexListItemActions.DELETE) {
              _deleteIndexConfirm();
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<IndexListItemActions>>[
            PopupMenuItem(
              value: IndexListItemActions.CREATECOLLECTION,
              child: Text("Create Collection"),
            ),
            PopupMenuItem(
              value: IndexListItemActions.BROWSECOLLECTIONS,
              child: Text("Browse Collections"),
            ),
            PopupMenuItem(
              value: IndexListItemActions.EDIT,
              child: Text("Edit"),
            ),
            PopupMenuItem(
              value: IndexListItemActions.DELETE,
              child: Text("Delete"),
            ),
          ],
        ),
      );
}
