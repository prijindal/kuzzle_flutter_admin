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
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final List<KuzzleCollection> collections;
  final String loadingError;
  final String addingError;
  final String deletingError;

  KuzzleIndex({
    this.loadingState = KuzzleState.INIT,
    this.collections = const <KuzzleCollection>[],
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
    this.loadingError,
    this.addingError,
    this.deletingError,
  });
  KuzzleIndex copyWith({
    List<KuzzleCollection> collections,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
    String loadingError,
    String addingError,
    String deletingError,
  }) {
    return KuzzleIndex(
      collections: collections ?? this.collections,
      loadingState: loadingState ?? this.loadingState,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
      loadingError: loadingError ?? this.loadingError,
      addingError: addingError ?? this.addingError,
      deletingError: deletingError ?? this.deletingError,
    );
  }

  Map<String, dynamic> toJson() => {
        'loadingState': loadingState.toString(),
        'addingState': addingState.toString(),
        'deletingState': deletingState.toString(),
        'loadingError': loadingError.toString(),
        'addingError': addingError.toString(),
        'deletingError': deletingError.toString(),
        'collections': collections.map((e) => e.toJson()).toList(),
      };
}

@immutable
class KuzzleIndexes {
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final String loadingError;
  final String addingError;
  final String deletingError;
  // Map of index to collections
  final Map<String, KuzzleIndex> indexMap;

  KuzzleIndexes({
    this.indexMap = const {},
    this.loadingState = KuzzleState.INIT,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
    this.loadingError,
    this.addingError,
    this.deletingError,
  });

  KuzzleIndexes copyWith({
    Map<String, KuzzleIndex> indexMap,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
    String loadingError,
    String addingError,
    String deletingError,
  }) {
    return KuzzleIndexes(
      indexMap: indexMap ?? this.indexMap,
      loadingState: loadingState ?? this.loadingState,
      addingState: addingState ?? this.addingState,
      deletingState: deletingState ?? this.deletingState,
      loadingError: loadingError ?? this.loadingError,
      addingError: addingError ?? this.addingError,
      deletingError: deletingError ?? this.deletingError,
    );
  }

  List<String> getIndexes() => indexMap.keys.toList();

  List<String> getCollections(String index) =>
      indexMap[index].collections.map((e) => e.name).toList();

  Map<String, dynamic> toJson() => {
        'loadingState': loadingState.toString(),
        'addingState': addingState.toString(),
        'deletingState': deletingState.toString(),
        'loadingError': loadingError.toString(),
        'addingError': addingError.toString(),
        'deletingError': deletingError.toString(),
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
