import 'dart:convert';

import 'package:meta/meta.dart';

enum KuzzleState { INIT, LOADING, LOADED, ERRORED }

@immutable
class KuzzleCollection {
  final String name;
  final String type;

  KuzzleCollection({
    @required this.name,
    @required this.type,
  });

  KuzzleCollection copyWith({String name, String type}) {
    return KuzzleCollection(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
      };
}

@immutable
class KuzzleIndex {
  final KuzzleState loadingState;
  final String loadingError;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final List<KuzzleCollection> collections;

  KuzzleIndex({
    this.loadingState = KuzzleState.INIT,
    this.loadingError,
    this.collections = const <KuzzleCollection>[],
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
  });
  KuzzleIndex copyWith({
    List<KuzzleCollection> collections,
    String loadingError,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
  }) {
    return KuzzleIndex(
      collections: collections ?? this.collections,
      loadingState: loadingState ?? this.loadingState,
      loadingError: loadingError ?? this.loadingError,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
    );
  }

  Map<String, dynamic> toJson() => {
        'loadingState': loadingState.toString(),
        'loadingError': loadingError,
        'addingState': addingState.toString(),
        'deletingState': deletingState.toString(),
        'collections': collections.map((e) => e.toJson()).toList(),
      };
}

@immutable
class KuzzleIndexes {
  final KuzzleState loadingState;
  final String loadingError;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  // Map of index to collections
  final Map<String, KuzzleIndex> indexMap;

  KuzzleIndexes({
    this.indexMap = const {},
    this.loadingState = KuzzleState.INIT,
    this.loadingError,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
  });

  KuzzleIndexes copyWith({
    Map<String, KuzzleIndex> indexMap,
    KuzzleState loadingState,
    String loadingError,
    KuzzleState addingState,
    KuzzleState deletingState,
  }) {
    return KuzzleIndexes(
      indexMap: indexMap ?? this.indexMap,
      loadingState: loadingState ?? this.loadingState,
      loadingError: loadingError ?? this.loadingError,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
    );
  }

  List<String> getIndexes() => indexMap.keys.toList();

  List<String> getCollections(String index) =>
      indexMap[index].collections.map((e) => e.name).toList();

  Map<String, dynamic> toJson() => {
        'loadingState': loadingState.toString(),
        'loadingError': loadingError,
        'addingState': addingState.toString(),
        'deletingState': deletingState.toString(),
        'indexMap': indexMap.map(
          (key, value) => MapEntry<String, dynamic>(
            key,
            value.toJson(),
          ),
        ),
      };
  @override
  String toString() {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    return encoder.convert(toJson());
  }
}
