// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environments _$EnvironmentsFromJson(Map<String, dynamic> json) {
  return Environments(
    environments: (json['environments'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : Environment.fromJson(e as Map<String, dynamic>)),
    ),
    defaultEnvironment: json['defaultEnvironment'] as String,
    isInitialized: json['isInitialized'] as bool,
  );
}

Map<String, dynamic> _$EnvironmentsToJson(Environments instance) =>
    <String, dynamic>{
      'environments': instance.environments,
      'defaultEnvironment': instance.defaultEnvironment,
      'isInitialized': instance.isInitialized,
    };
