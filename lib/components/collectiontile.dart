import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/document.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/pages/collection.dart';
import 'package:kuzzleflutteradmin/pages/newdocumentpage.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum CollectionListItemActions {
  DELETE,
  EDIT,
  BROWSECOLLECTIONS,
  CREATEDOCUMENT
}

class CollectionListTile extends StatelessWidget {
  const CollectionListTile({
    @required this.index,
    @required this.collection,
  });
  final String index;
  final KuzzleCollection collection;

  void _goToCollectionPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionPage(
          index: index,
          collection: collection,
        ),
      ),
    );
  }

  Future<void> _deleteCollectionConfirm(BuildContext context) async {
    final confirm = await confirmDialog(context, 'Delete ${collection.name}',
        'Are you sure you want to delete this collection');
    if (confirm) {
      StoreProvider.of<AppState>(context).dispatch(
        deleteKuzzleCollection(index, collection.name),
      );
    }
  }

  Future<void> _goToAddDocumentPage(BuildContext context) async {
    await Navigator.of(context).push<KuzzleDocument>(
      MaterialPageRoute(
        builder: (context) => NewDocumentPage(
          index: index,
          collection: collection,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(collection.name),
        onTap: () => _goToCollectionPage(context),
        trailing: PopupMenuButton<CollectionListItemActions>(
          onSelected: (action) {
            if (action == CollectionListItemActions.BROWSECOLLECTIONS) {
              _goToCollectionPage(context);
            } else if (action == CollectionListItemActions.CREATEDOCUMENT) {
              _goToAddDocumentPage(context);
            } else if (action == CollectionListItemActions.EDIT) {
            } else if (action == CollectionListItemActions.DELETE) {
              _deleteCollectionConfirm(context);
            }
          },
          itemBuilder: (context) =>
              const <PopupMenuEntry<CollectionListItemActions>>[
            PopupMenuItem(
              value: CollectionListItemActions.CREATEDOCUMENT,
              child: Text('Create Document'),
            ),
            PopupMenuItem(
              value: CollectionListItemActions.BROWSECOLLECTIONS,
              child: Text('Browse Documents'),
            ),
            PopupMenuItem(
              value: CollectionListItemActions.EDIT,
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: CollectionListItemActions.DELETE,
              child: Text('Delete'),
            ),
          ],
        ),
      );
}
