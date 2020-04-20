import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
@immutable
class KuzzleDocument {
  const KuzzleDocument({
    @required this.id,
    @required this.source,
    this.score,
  });

  factory KuzzleDocument.fromJson(Map<String, dynamic> json) =>
      _$KuzzleDocumentFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_score')
  final int score;
  @JsonKey(name: '_source')
  final Map<String, dynamic> source;

  KuzzleInfo get kuzzleInfo =>
      KuzzleInfo.fromJson(source['_kuzzle_info'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$KuzzleDocumentToJson(this);
}

@JsonSerializable()
@immutable
class KuzzleInfo {
  const KuzzleInfo({
    this.author,
    this.createdAt,
    this.updatedAt,
    this.updater,
  });

  factory KuzzleInfo.fromJson(Map<String, dynamic> json) =>
      _$KuzzleInfoFromJson(json);

  final String author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String updater;

  Map<String, dynamic> toJson() => _$KuzzleInfoToJson(this);
}
