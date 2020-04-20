// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuzzleauth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KuzzleAuth _$KuzzleAuthFromJson(Map<String, dynamic> json) {
  return KuzzleAuth(
    token: json['token'] as String,
    loginState: _$enumDecodeNullable(_$KuzzleStateEnumMap, json['loginState']),
    logoutState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['logoutState']),
    adminCheckState:
        _$enumDecodeNullable(_$KuzzleStateEnumMap, json['adminCheckState']),
    loginError: json['loginError'] as String,
    logoutError: json['logoutError'] as String,
    adminCheckError: json['adminCheckError'] as String,
    adminCheckResult: json['adminCheckResult'] as bool,
  );
}

Map<String, dynamic> _$KuzzleAuthToJson(KuzzleAuth instance) =>
    <String, dynamic>{
      'loginState': _$KuzzleStateEnumMap[instance.loginState],
      'logoutState': _$KuzzleStateEnumMap[instance.logoutState],
      'adminCheckState': _$KuzzleStateEnumMap[instance.adminCheckState],
      'loginError': instance.loginError,
      'logoutError': instance.logoutError,
      'adminCheckError': instance.adminCheckError,
      'token': instance.token,
      'adminCheckResult': instance.adminCheckResult,
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
