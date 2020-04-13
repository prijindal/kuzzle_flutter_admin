// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuzzleindexes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KuzzleCollection _$KuzzleCollectionFromJson(Map<String, dynamic> json) {
  return KuzzleCollection(
    name: json['name'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$KuzzleCollectionToJson(KuzzleCollection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

KuzzleIndex _$KuzzleIndexFromJson(Map<String, dynamic> json) {
  return KuzzleIndex(
    loadingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['loadingState']),
    collections: (json['collections'] as List)
        ?.map((e) => e == null
            ? null
            : KuzzleCollection.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    addingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['addingState']),
    deletingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['deletingState']),
    loadingError: json['loadingError'] as String,
    addingError: json['addingError'] as String,
    deletingError: json['deletingError'] as String,
  );
}

Map<String, dynamic> _$KuzzleIndexToJson(KuzzleIndex instance) =>
    <String, dynamic>{
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
      'addingState': _$KuzzleStateEnumMap[instance.addingState],
      'deletingState': _$KuzzleStateEnumMap[instance.deletingState],
      'collections': instance.collections,
      'loadingError': instance.loadingError,
      'addingError': instance.addingError,
      'deletingError': instance.deletingError,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$KuzzleStateEnumMap = {
  KuzzleState.INIT: 'INIT',
  KuzzleState.LOADING: 'LOADING',
  KuzzleState.LOADED: 'LOADED',
  KuzzleState.ERRORED: 'ERRORED',
};

KuzzleIndexes _$KuzzleIndexesFromJson(Map<String, dynamic> json) {
  return KuzzleIndexes(
    indexMap: (json['indexMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : KuzzleIndex.fromJson(e as Map<String, dynamic>)),
    ),
    loadingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['loadingState']),
    addingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['addingState']),
    deletingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['deletingState']),
    loadingError: json['loadingError'] as String,
    addingError: json['addingError'] as String,
    deletingError: json['deletingError'] as String,
  );
}

Map<String, dynamic> _$KuzzleIndexesToJson(KuzzleIndexes instance) =>
    <String, dynamic>{
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
      'addingState': _$KuzzleStateEnumMap[instance.addingState],
      'deletingState': _$KuzzleStateEnumMap[instance.deletingState],
      'loadingError': instance.loadingError,
      'addingError': instance.addingError,
      'deletingError': instance.deletingError,
      'indexMap': instance.indexMap,
    };
