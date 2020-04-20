// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KuzzleDocument _$KuzzleDocumentFromJson(Map<String, dynamic> json) {
  return KuzzleDocument(
    id: json['_id'] as String,
    source: json['_source'] as Map<String, dynamic>,
    score: json['_score'] as int,
  );
}

Map<String, dynamic> _$KuzzleDocumentToJson(KuzzleDocument instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_score': instance.score,
      '_source': instance.source,
    };

KuzzleInfo _$KuzzleInfoFromJson(Map<String, dynamic> json) {
  return KuzzleInfo(
    author: json['author'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    updater: json['updater'] as String,
  );
}

Map<String, dynamic> _$KuzzleInfoToJson(KuzzleInfo instance) =>
    <String, dynamic>{
      'author': instance.author,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'updater': instance.updater,
    };
