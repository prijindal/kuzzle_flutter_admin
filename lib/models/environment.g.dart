// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(Map<String, dynamic> json) {
  return Environment(
    name: json['name'] as String,
    color: json['color'] as String,
    host: json['host'] as String,
    port: json['port'] as int,
    ssl: json['ssl'] as bool,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'host': instance.host,
      'port': instance.port,
      'ssl': instance.ssl,
      'token': instance.token,
    };
