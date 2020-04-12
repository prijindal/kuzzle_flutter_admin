import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/index.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class CollectionsPageRouteArguments {
  final String index;
  CollectionsPageRouteArguments({@required this.index});
}

class CollectionsPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CollectionsPage(
        index: (ModalRoute.of(context).settings.arguments
                as CollectionsPageRouteArguments)
            .index,
      );
}

class CollectionsPage extends StatefulWidget {
  final String index;
  CollectionsPage({@required this.index});

  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  void didChangeDependencies() {
    if (_kuzzleIndex != null && _kuzzleIndex.loadingState == KuzzleState.INIT) {
      StoreProvider.of<AppState>(context).dispatch(
        getKuzzleCollections(widget.index),
      );
    }
    super.didChangeDependencies();
  }

  KuzzleIndex get _kuzzleIndex {
    if (StoreProvider.of<AppState>(context)
        .state
        .kuzzleindexes
        .indexMap
        .containsKey(widget.index)) {
      return StoreProvider.of<AppState>(context)
          .state
          .kuzzleindexes
          .indexMap[widget.index];
    } else {
      return null;
    }
  }

  void _deleteCollection(String collection) async {
    var confirm = await confirmDialog(context, "Delete $collection",
        "Are you sure you want to delete this collection");
    if (confirm) {
      StoreProvider.of<AppState>(context).dispatch(
        deleteKuzzleCollection(widget.index, collection),
      );
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
  Widget build(BuildContext context) => Scaffold(
        appBar: KuzzleAppBar(
          subtitle: '${widget.index}/collections',
        ),
        drawer: KuzzleDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _goToAddCollectionPage,
        ),
        body: StoreConnector<AppState, List<String>>(
          converter: (store) =>
              store.state.kuzzleindexes.getCollections(widget.index),
          builder: (context, collections) => ListView.builder(
            itemCount: collections.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(collections[i]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteCollection(collections[i]),
              ),
            ),
          ),
        ),
      );
}