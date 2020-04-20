import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

enum IndexListItemActions { DELETE, EDIT, BROWSECOLLECTIONS, CREATECOLLECTION }

class IndexListTile extends StatelessWidget {
  const IndexListTile({@required this.index});
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
