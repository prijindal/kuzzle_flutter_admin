import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'events.dart';

bool initKuzzleIndex() {
  if (FlutterKuzzle.instance != null) {
    if (FlutterKuzzle.instance.index == null) {
      FlutterKuzzle.instance.index = IndexController(FlutterKuzzle.instance);
    }
    if (FlutterKuzzle.instance.collection == null) {
      FlutterKuzzle.instance.collection =
          CollectionController(FlutterKuzzle.instance);
    }
    return true;
  }
  return false;
}

void getKuzzleIndexes(Store<dynamic> store) async {
  store.dispatch(GetKuzzleIndexesAction());
  if (initKuzzleIndex()) {
    try {
      var indexes = await FlutterKuzzle.instance.index.list();
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

ThunkAction<dynamic> addKuzzleIndex(String index) {
  return (Store<dynamic> store) async {
    store.dispatch(AddKuzzleIndexAction(index));
    if (initKuzzleIndex()) {
      try {
        var success = await FlutterKuzzle.instance.index.create(index);
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
              "Failed",
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
}

ThunkAction<dynamic> deleteKuzzleIndex(String index) {
  return (Store<dynamic> store) async {
    store.dispatch(DeleteKuzzleIndexAction(index));
    if (initKuzzleIndex()) {
      try {
        var success = await FlutterKuzzle.instance.index.delete(index);
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
              "Failed",
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
}

ThunkAction<dynamic> getKuzzleCollections(String index) {
  return (Store<dynamic> store) async {
    store.dispatch(GetKuzzleCollectionsAction(index));
    if (initKuzzleIndex()) {
      try {
        var collectionMap = await FlutterKuzzle.instance.collection.list(index);
        print(collectionMap);
        List<KuzzleCollection> collections =
            (collectionMap["collections"] as List<dynamic>)
                .map(
                  (e) => KuzzleCollection(
                    name: e["name"],
                    type: e["type"],
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
}

ThunkAction<dynamic> addKuzzleCollection(
    String index, KuzzleCollection collection) {
  return (Store<dynamic> store) async {
    store.dispatch(AddKuzzleCollectionAction(index, collection));
    if (initKuzzleIndex()) {
      try {
        var collectionMap = await FlutterKuzzle.instance.collection
            .create(index, collection.name);
        if (collectionMap["acknowledged"] == false) {
          throw new Error();
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
}

ThunkAction<dynamic> deleteKuzzleCollection(
    String index, String collectionName) {
  return (Store<dynamic> store) async {
    store.dispatch(DeleteKuzzleCollectionAction(index, collectionName));
    if (initKuzzleIndex()) {
      try {
        var success = await FlutterKuzzle.instance.collection
            .delete(index, collectionName);
        if (success == false) {
          throw new Error();
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
}
