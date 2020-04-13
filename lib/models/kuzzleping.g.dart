// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuzzleping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KuzzlePing _$KuzzlePingFromJson(Map<String, dynamic> json) {
  return KuzzlePing(
    errorMessage: json['errorMessage'] as String,
    loadingState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['loadingState']),
  );
}

Map<String, dynamic> _$KuzzlePingToJson(KuzzlePing instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
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
