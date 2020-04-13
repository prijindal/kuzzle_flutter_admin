// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuzzlesecurity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KuzzleSecurityUser _$KuzzleSecurityUserFromJson(Map<String, dynamic> json) {
  return KuzzleSecurityUser(
    uid: json['uid'] as String,
    content: json['content'] as Map<String, dynamic>,
    meta: json['meta'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$KuzzleSecurityUserToJson(KuzzleSecurityUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'content': instance.content,
      'meta': instance.meta,
    };

KuzzleSecurityUsers _$KuzzleSecurityUsersFromJson(Map<String, dynamic> json) {
  return KuzzleSecurityUsers(
    users: (json['users'] as List)
        ?.map((e) => e == null
            ? null
            : KuzzleSecurityUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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

Map<String, dynamic> _$KuzzleSecurityUsersToJson(
        KuzzleSecurityUsers instance) =>
    <String, dynamic>{
      'users': instance.users,
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
      'addingState': _$KuzzleStateEnumMap[instance.addingState],
      'deletingState': _$KuzzleStateEnumMap[instance.deletingState],
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

KuzzleSecurityProfile _$KuzzleSecurityProfileFromJson(
    Map<String, dynamic> json) {
  return KuzzleSecurityProfile(
    uid: json['uid'] as String,
    policies: json['policies'] as List,
  );
}

Map<String, dynamic> _$KuzzleSecurityProfileToJson(
        KuzzleSecurityProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'policies': instance.policies,
    };

KuzzleSecurityProfiles _$KuzzleSecurityProfilesFromJson(
    Map<String, dynamic> json) {
  return KuzzleSecurityProfiles(
    profiles: (json['profiles'] as List)
        ?.map((e) => e == null
            ? null
            : KuzzleSecurityProfile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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

Map<String, dynamic> _$KuzzleSecurityProfilesToJson(
        KuzzleSecurityProfiles instance) =>
    <String, dynamic>{
      'profiles': instance.profiles,
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
      'addingState': _$KuzzleStateEnumMap[instance.addingState],
      'deletingState': _$KuzzleStateEnumMap[instance.deletingState],
      'loadingError': instance.loadingError,
      'addingError': instance.addingError,
      'deletingError': instance.deletingError,
    };

KuzzleSecurityRole _$KuzzleSecurityRoleFromJson(Map<String, dynamic> json) {
  return KuzzleSecurityRole(
    uid: json['uid'] as String,
    controllers: json['controllers'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$KuzzleSecurityRoleToJson(KuzzleSecurityRole instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'controllers': instance.controllers,
    };

KuzzleSecurityRoles _$KuzzleSecurityRolesFromJson(Map<String, dynamic> json) {
  return KuzzleSecurityRoles(
    roles: (json['roles'] as List)
        ?.map((e) => e == null
            ? null
            : KuzzleSecurityRole.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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

Map<String, dynamic> _$KuzzleSecurityRolesToJson(
        KuzzleSecurityRoles instance) =>
    <String, dynamic>{
      'roles': instance.roles,
      'loadingState': _$KuzzleStateEnumMap[instance.loadingState],
      'addingState': _$KuzzleStateEnumMap[instance.addingState],
      'deletingState': _$KuzzleStateEnumMap[instance.deletingState],
      'loadingError': instance.loadingError,
      'addingError': instance.addingError,
      'deletingError': instance.deletingError,
    };

KuzzleSecurity _$KuzzleSecurityFromJson(Map<String, dynamic> json) {
  return KuzzleSecurity(
    users: json['users'] == null
        ? null
        : KuzzleSecurityUsers.fromJson(json['users'] as Map<String, dynamic>),
    profiles: json['profiles'] == null
        ? null
        : KuzzleSecurityProfiles.fromJson(
            json['profiles'] as Map<String, dynamic>),
    roles: json['roles'] == null
        ? null
        : KuzzleSecurityRoles.fromJson(json['roles'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$KuzzleSecurityToJson(KuzzleSecurity instance) =>
    <String, dynamic>{
      'users': instance.users,
      'profiles': instance.profiles,
      'roles': instance.roles,
    };
