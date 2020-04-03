import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'environment.g.dart';

@JsonSerializable()
class Environment {
  Environment({
    @required this.name,
  });
  String name;
  String color;
  String host;
  int port;
  bool ssl;
  String token;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$EnvironmentFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}
