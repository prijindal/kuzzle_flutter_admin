import 'state.dart';
import 'events.dart';

KuzzleIndexes kuzzleReducer(KuzzleIndexes state, KuzzleIndexAction action) {
  if (state == null) {
    state = KuzzleIndexes();
  }
  if (action is ResetKuzzleIndexAction) {
    return KuzzleIndexes();
  } else if (action is GetKuzzleIndexesAction) {
    return state.copyWith(
      loadingError: null,
      loadingState: KuzzleState.LOADING,
    );
  } else if (action is GetSuccessKuzzleIndexesAction) {
    Map<String, KuzzleIndex> indexMap = <String, KuzzleIndex>{};
    for (var index in action.indexes) {
      indexMap[index] = KuzzleIndex();
    }
    return state.copyWith(
      loadingError: null,
      loadingState: KuzzleState.LOADED,
      indexMap: indexMap,
    );
  } else if (action is GetErroredKuzzleIndexesAction) {
    return state.copyWith(
      loadingState: KuzzleState.ERRORED,
      loadingError: action.errorMessage,
    );
  } else if (action is AddKuzzleIndexAction) {
    return state.copyWith(
      addingState: KuzzleState.LOADING,
    );
  } else if (action is AddSuccessKuzzleIndexAction) {
    var indexMap = state.indexMap;
    indexMap[action.index] = KuzzleIndex();
    return state.copyWith(
      addingState: KuzzleState.LOADED,
      indexMap: indexMap,
    );
  } else if (action is AddErroredKuzzleIndexAction) {
    return state.copyWith(
      addingError: action.errorMessage,
      addingState: KuzzleState.ERRORED,
    );
  } else if (action is DeleteKuzzleIndexAction) {
    return state.copyWith(
      deletingState: KuzzleState.LOADING,
    );
  } else if (action is DeleteSuccessKuzzleIndexAction) {
    var indexMap = state.indexMap;
    indexMap.remove(action.index);
    return state.copyWith(
      deletingState: KuzzleState.LOADED,
      indexMap: indexMap,
    );
  } else if (action is DeleteErroredKuzzleIndexAction) {
    return state.copyWith(
      deletingError: action.errorMessage,
      deletingState: KuzzleState.ERRORED,
    );
  } else if (action is GetKuzzleCollectionsAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  loadingError: null,
                  loadingState: KuzzleState.LOADING,
                ),
        ),
      ),
    );
  } else if (action is GetSuccessKuzzleCollectionsAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  loadingState: KuzzleState.LOADED,
                  loadingError: null,
                  collections: action.collections,
                ),
        ),
      ),
    );
  } else if (action is GetErroredKuzzleCollectionsAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  loadingError: action.errorMessage,
                  loadingState: KuzzleState.ERRORED,
                ),
        ),
      ),
    );
  } else if (action is AddKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  addingState: KuzzleState.LOADING,
                ),
        ),
      ),
    );
  } else if (action is AddSuccessKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  addingState: KuzzleState.LOADED,
                  collections: value.collections..add(action.collection),
                ),
        ),
      ),
    );
  } else if (action is AddErroredKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  addingError: action.errorMessage,
                  addingState: KuzzleState.ERRORED,
                ),
        ),
      ),
    );
  } else if (action is DeleteKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  deletingState: KuzzleState.LOADING,
                ),
        ),
      ),
    );
  } else if (action is DeleteSuccessKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  deletingState: KuzzleState.LOADED,
                  collections: value.collections
                      .where((element) => element.name != action.collectionName)
                      .toList(),
                ),
        ),
      ),
    );
  } else if (action is DeleteErroredKuzzleCollectionAction) {
    return state.copyWith(
      indexMap: state.indexMap.map(
        (key, value) => MapEntry<String, KuzzleIndex>(
          key,
          key != action.index
              ? value
              : value.copyWith(
                  deletingError: action.errorMessage,
                  deletingState: KuzzleState.ERRORED,
                ),
        ),
      ),
    );
  }
  return state;
}
