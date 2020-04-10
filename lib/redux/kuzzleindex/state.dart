import 'package:meta/meta.dart';

enum KuzzleState { INIT, LOADING, LOADED, ERRORED }

@immutable
class KuzzleIndex {
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final List<String> collections;

  KuzzleIndex({
    this.loadingState = KuzzleState.INIT,
    this.collections = const <String>[],
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
  });
  KuzzleIndex copyWith({
    List<String> collections,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
  }) {
    return KuzzleIndex(
      collections: collections ?? this.collections,
      loadingState: loadingState ?? this.loadingState,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
    );
  }
}

@immutable
class KuzzleIndexes {
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  // Map of index to collections
  final Map<String, KuzzleIndex> indexMap;

  KuzzleIndexes({
    this.indexMap = const {},
    this.loadingState = KuzzleState.INIT,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
  });

  KuzzleIndexes copyWith({
    Map<String, KuzzleIndex> indexMap,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
  }) {
    return KuzzleIndexes(
      indexMap: indexMap ?? this.indexMap,
      loadingState: loadingState ?? this.loadingState,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
    );
  }

  List<String> getIndexes() => indexMap.keys;

  List<String> getCollections(String index) => indexMap[index].collections;
}
