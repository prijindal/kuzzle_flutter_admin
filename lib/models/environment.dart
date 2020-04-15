import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'environment.g.dart';

@JsonSerializable()
@immutable
class Environment {
  const Environment({
    @required this.name,
    this.color,
    this.host,
    this.port,
    this.ssl,
    this.token,
  });

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  final String name;
  final String color;
  final String host;
  final int port;
  final bool ssl;
  final String token;

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}
