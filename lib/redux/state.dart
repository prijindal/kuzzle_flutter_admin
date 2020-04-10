import 'dart:convert';

import 'package:meta/meta.dart';
import 'environments/index.dart';
import 'kuzzleindex/index.dart';

@immutable
class AppState {
  final Environments environments;
  final KuzzleIndexes kuzzleindexes;
  AppState({
    Environments environments,
    KuzzleIndexes kuzzleindexes,
  })  : this.environments = environments ?? Environments(),
        this.kuzzleindexes = kuzzleindexes ?? KuzzleIndexes();

  Map<String, dynamic> toJson() => {
        'environments': environments.toJson(),
        'kuzzleindexes': kuzzleindexes.toJson(),
      };

  @override
  String toString() => jsonEncode(toJson());
}
