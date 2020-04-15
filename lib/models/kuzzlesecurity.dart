import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kuzzlesecurity.g.dart';

@JsonSerializable()
@immutable
class KuzzleSecurityUser {
  const KuzzleSecurityUser({
    @required this.uid,
    this.content = const <String, dynamic>{},
    this.meta = const <String, dynamic>{},
    this.loadingState = KuzzleState.INIT,
    this.savingState = KuzzleState.INIT,
    this.loadingError,
    this.savingError,
  }) : assert(uid != null);

  factory KuzzleSecurityUser.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityUserFromJson(json);

  final String uid;
  final Map<String, dynamic> content;
  final Map<String, dynamic> meta;
  final KuzzleState loadingState;
  final KuzzleState savingState;
  final String loadingError;
  final String savingError;

  List<String> get profileIds => (content['profileIds'] as List<dynamic>)
      .map<String>((e) => e as String)
      .toList();
  // set profileIds(List<String> profileIds) {
  //   content['profileIds'] = profileIds;
  // }

  String get name => content['name'] as String;
  // set name(String name) {
  //   content['name'] = name;
  // }

  KuzzleSecurityUser copyWith({
    String uid,
    Map<String, dynamic> content,
    Map<String, dynamic> meta,
    KuzzleState loadingState,
    KuzzleState savingState,
    String loadingError,
    String savingError,
  }) =>
      KuzzleSecurityUser(
        uid: uid ?? this.uid,
        content: content ?? this.content,
        meta: meta ?? this.meta,
        loadingState: loadingState ?? this.loadingState,
        savingState: savingState ?? this.savingState,
        loadingError: loadingError ?? this.loadingError,
        savingError: savingError ?? this.savingError,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityUserToJson(this);
}

@JsonSerializable()
@immutable
class KuzzleSecurityUsers {
  const KuzzleSecurityUsers({
    this.users = const <KuzzleSecurityUser>[],
    this.loadingState = KuzzleState.INIT,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
    this.loadingError,
    this.addingError,
    this.deletingError,
  });

  factory KuzzleSecurityUsers.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityUsersFromJson(json);

  final List<KuzzleSecurityUser> users;
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final String loadingError;
  final String addingError;
  final String deletingError;

  KuzzleSecurityUsers copyWith({
    List<KuzzleSecurityUser> users,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
    String loadingError,
    String addingError,
    String deletingError,
  }) =>
      KuzzleSecurityUsers(
        users: users ?? this.users,
        loadingState: loadingState ?? this.loadingState,
        addingState: addingState ?? this.addingState,
        deletingState: deletingState ?? this.deletingState,
        loadingError: loadingError ?? this.loadingError,
        addingError: addingError ?? this.addingError,
        deletingError: deletingError ?? this.deletingError,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityUsersToJson(this);
}

@immutable
@JsonSerializable()
class KuzzleSecurityProfile {
  const KuzzleSecurityProfile({
    @required this.uid,
    this.policies = const <dynamic>[],
    this.loadingState = KuzzleState.INIT,
    this.savingState = KuzzleState.INIT,
    this.loadingError,
    this.savingError,
  }) : assert(uid != null);

  factory KuzzleSecurityProfile.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityProfileFromJson(json);

  final String uid;
  final List<dynamic> policies;
  final KuzzleState loadingState;
  final KuzzleState savingState;
  final String loadingError;
  final String savingError;

  KuzzleSecurityProfile copyWith({
    String uid,
    List<dynamic> policies,
    KuzzleState loadingState,
    KuzzleState savingState,
    String loadingError,
    String savingError,
  }) =>
      KuzzleSecurityProfile(
        uid: uid ?? this.uid,
        policies: policies ?? this.policies,
        loadingState: loadingState ?? this.loadingState,
        savingState: savingState ?? this.savingState,
        loadingError: loadingError ?? this.loadingError,
        savingError: savingError ?? this.savingError,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityProfileToJson(this);
}

@immutable
@JsonSerializable()
class KuzzleSecurityProfiles {
  const KuzzleSecurityProfiles({
    this.profiles = const <KuzzleSecurityProfile>[],
    this.loadingState = KuzzleState.INIT,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
    this.loadingError,
    this.addingError,
    this.deletingError,
  });

  factory KuzzleSecurityProfiles.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityProfilesFromJson(json);

  final List<KuzzleSecurityProfile> profiles;
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final String loadingError;
  final String addingError;
  final String deletingError;

  KuzzleSecurityProfiles copyWith({
    List<KuzzleSecurityProfile> profiles,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
    String loadingError,
    String addingError,
    String deletingError,
  }) =>
      KuzzleSecurityProfiles(
        profiles: profiles ?? this.profiles,
        loadingState: loadingState ?? this.loadingState,
        addingState: addingState ?? this.addingState,
        deletingState: deletingState ?? this.deletingState,
        loadingError: loadingError ?? this.loadingError,
        addingError: addingError ?? this.addingError,
        deletingError: deletingError ?? this.deletingError,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityProfilesToJson(this);
}

@immutable
@JsonSerializable()
class KuzzleSecurityRole {
  const KuzzleSecurityRole({
    @required this.uid,
    this.controllers = const <String, dynamic>{},
  }) : assert(uid != null);

  factory KuzzleSecurityRole.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityRoleFromJson(json);

  final String uid;
  final Map<String, dynamic> controllers;

  KuzzleSecurityRole copyWith({
    String uid,
    Map<String, dynamic> controllers,
  }) =>
      KuzzleSecurityRole(
        uid: uid ?? this.uid,
        controllers: controllers ?? this.controllers,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityRoleToJson(this);
}

@immutable
@JsonSerializable()
class KuzzleSecurityRoles {
  const KuzzleSecurityRoles({
    this.roles = const <KuzzleSecurityRole>[],
    this.loadingState = KuzzleState.INIT,
    this.addingState = KuzzleState.INIT,
    this.deletingState = KuzzleState.INIT,
    this.loadingError,
    this.addingError,
    this.deletingError,
  });

  factory KuzzleSecurityRoles.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityRolesFromJson(json);

  final List<KuzzleSecurityRole> roles;
  final KuzzleState loadingState;
  final KuzzleState addingState;
  final KuzzleState deletingState;
  final String loadingError;
  final String addingError;
  final String deletingError;

  KuzzleSecurityRoles copyWith({
    List<KuzzleSecurityRole> roles,
    KuzzleState loadingState,
    KuzzleState addingState,
    KuzzleState deletingState,
    String loadingError,
    String addingError,
    String deletingError,
  }) =>
      KuzzleSecurityRoles(
        roles: roles ?? this.roles,
        loadingState: loadingState ?? this.loadingState,
        addingState: addingState ?? this.addingState,
        deletingState: deletingState ?? this.deletingState,
        loadingError: loadingError ?? this.loadingError,
        addingError: addingError ?? this.addingError,
        deletingError: deletingError ?? this.deletingError,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityRolesToJson(this);
}

@immutable
@JsonSerializable()
class KuzzleSecurity {
  const KuzzleSecurity({
    KuzzleSecurityUsers users,
    KuzzleSecurityProfiles profiles,
    KuzzleSecurityRoles roles,
  })  : this.users = users ?? const KuzzleSecurityUsers(),
        this.profiles = profiles ?? const KuzzleSecurityProfiles(),
        this.roles = roles ?? const KuzzleSecurityRoles();

  factory KuzzleSecurity.fromJson(Map<String, dynamic> json) =>
      _$KuzzleSecurityFromJson(json);

  final KuzzleSecurityUsers users;
  final KuzzleSecurityProfiles profiles;
  final KuzzleSecurityRoles roles;

  KuzzleSecurity copyWith({
    KuzzleSecurityUsers users,
    KuzzleSecurityProfiles profiles,
    KuzzleSecurityRoles roles,
  }) =>
      KuzzleSecurity(
        users: users ?? this.users,
        profiles: profiles ?? this.profiles,
        roles: roles ?? this.roles,
      );

  Map<String, dynamic> toJson() => _$KuzzleSecurityToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
