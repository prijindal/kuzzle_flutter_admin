import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'events.dart';

Future<void> getKuzzleIndexes(Store<dynamic> store) async {
  store.dispatch(GetKuzzleIndexesAction());
  if (initKuzzleIndex()) {
    try {
      final indexes = await FlutterKuzzle.instance.index.list();
      store.dispatch(
        GetSuccessKuzzleIndexesAction(
          indexes,
        ),
      );
    } catch (e) {
      store.dispatch(
        GetErroredKuzzleIndexesAction(
          e.toString(),
        ),
      );
    }
  }
}

ThunkAction<dynamic> addKuzzleIndex(String index) => (store) async {
      store.dispatch(AddKuzzleIndexAction(index));
      if (initKuzzleIndex()) {
        try {
          final success = await FlutterKuzzle.instance.index.create(index);
          if (success) {
            store.dispatch(
              AddSuccessKuzzleIndexAction(
                index,
              ),
            );
          } else {
            store.dispatch(
              AddErroredKuzzleIndexAction(
                index,
                'Failed',
              ),
            );
          }
        } catch (e) {
          store.dispatch(
            AddErroredKuzzleIndexAction(
              index,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> deleteKuzzleIndex(String index) => (store) async {
      store.dispatch(DeleteKuzzleIndexAction(index));
      if (initKuzzleIndex()) {
        try {
          final success = await FlutterKuzzle.instance.index.delete(index);
          if (success) {
            store.dispatch(
              DeleteSuccessKuzzleIndexAction(
                index,
              ),
            );
          } else {
            store.dispatch(
              DeleteErroredKuzzleIndexAction(
                index,
                'Failed',
              ),
            );
          }
        } catch (e) {
          store.dispatch(
            DeleteErroredKuzzleIndexAction(
              index,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> getKuzzleCollections(String index) => (store) async {
      store.dispatch(GetKuzzleCollectionsAction(index));
      if (initKuzzleIndex()) {
        try {
          final collectionMap =
              await FlutterKuzzle.instance.collection.list(index);
          final collections = (collectionMap['collections'] as List<dynamic>)
              .map(
                (e) => KuzzleCollection(
                  name: e['name'] as String,
                  type: e['type'] as String,
                ),
              )
              .toList();
          store.dispatch(GetSuccessKuzzleCollectionsAction(
            index,
            collections,
          ));
        } catch (e) {
          store.dispatch(
            GetErroredKuzzleCollectionsAction(
              index,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> addKuzzleCollection(
        String index, KuzzleCollection collection) =>
    (store) async {
      store.dispatch(AddKuzzleCollectionAction(index, collection));
      if (initKuzzleIndex()) {
        try {
          final collectionMap = await FlutterKuzzle.instance.collection
              .create(index, collection.name);
          if (collectionMap['acknowledged'] == false) {
            throw Error();
          }
          store.dispatch(AddSuccessKuzzleCollectionAction(
            index,
            collection,
          ));
        } catch (e) {
          store.dispatch(
            AddErroredKuzzleCollectionAction(
              index,
              collection,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> deleteKuzzleCollection(
        String index, String collectionName) =>
    (store) async {
      store.dispatch(DeleteKuzzleCollectionAction(index, collectionName));
      if (initKuzzleIndex()) {
        try {
          final success = await FlutterKuzzle.instance.collection
              .delete(index, collectionName);
          if (success == false) {
            throw Error();
          }
          store.dispatch(
            DeleteSuccessKuzzleCollectionAction(
              index,
              collectionName,
            ),
          );
        } catch (e) {
          print(e);
          store.dispatch(
            DeleteErroredKuzzleCollectionAction(
              index,
              collectionName,
              e.toString(),
            ),
          );
        }
      }
    };
