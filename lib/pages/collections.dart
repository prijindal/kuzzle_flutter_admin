import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import 'package:redux/redux.dart';

class CollectionsPageRouteArguments {
  CollectionsPageRouteArguments({@required this.index});
  final String index;
}

class CollectionsPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CollectionsPage(
        index: (ModalRoute.of(context).settings.arguments
                as CollectionsPageRouteArguments)
            .index,
      );
}

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({@required this.index});
  final String index;

  KuzzleIndex _kuzzleIndex(Store<AppState> store) {
    if (store.state.kuzzleindexes.indexMap.containsKey(index)) {
      return store.state.kuzzleindexes.indexMap[index];
    } else {
      return null;
    }
  }

  Future<void> _deleteCollection(
      String collection, BuildContext context) async {
    final confirm = await confirmDialog(context, 'Delete $collection',
        'Are you sure you want to delete this collection');
    if (confirm) {
      StoreProvider.of<AppState>(context).dispatch(
        deleteKuzzleCollection(index, collection),
      );
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

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: '$index/collections',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _goToAddCollectionPage(context),
        ),
        body: StoreConnector<AppState, List<String>>(
          onInit: (store) {
            if (_kuzzleIndex(store) != null &&
                _kuzzleIndex(store).loadingState != KuzzleState.LOADING) {
              store.dispatch(getKuzzleCollections(index));
            }
          },
          converter: (store) => store.state.kuzzleindexes.getCollections(index),
          builder: (context, collections) => ListView.builder(
            itemCount: collections.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(collections[i]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteCollection(collections[i], context),
              ),
            ),
          ),
        ),
      );
}
