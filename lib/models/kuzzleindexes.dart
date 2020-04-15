import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:meta/meta.dart';

part 'kuzzleindexes.g.dart';

@JsonSerializable()
@immutable
class KuzzleCollection {
  final String name;
  final String type;

  KuzzleCollection({
    @required this.name,
    this.type = 'stored',
  });

  KuzzleCollection copyWith({String name, String type}) {
    return KuzzleCollection(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  factory KuzzleCollection.fromJson(Map<String, dynamic> json) =>
      _$KuzzleCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$KuzzleCollectionToJson(this);
}

@JsonSerializable()
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

  factory KuzzleIndex.fromJson(Map<String, dynamic> json) =>
      _$KuzzleIndexFromJson(json);

  Map<String, dynamic> toJson() => _$KuzzleIndexToJson(this);
}

@JsonSerializable()
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

  factory KuzzleIndexes.fromJson(Map<String, dynamic> json) =>
      _$KuzzleIndexesFromJson(json);

  Map<String, dynamic> toJson() => _$KuzzleIndexesToJson(this);

  @override
  String toString() {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    return encoder.convert(toJson());
  }
}
