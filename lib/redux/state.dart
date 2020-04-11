import 'dart:convert';

import 'package:kuzzleflutteradmin/redux/kuzzleping/state.dart';
import 'package:meta/meta.dart';
import 'environments/index.dart';
import 'kuzzleindex/index.dart';

@immutable
class AppState {
  final Environments environments;
  final KuzzleIndexes kuzzleindexes;
  final KuzzlePing kuzzleping;
  AppState({
    Environments environments,
    KuzzleIndexes kuzzleindexes,
    KuzzlePing kuzzleping,
  })  : this.environments = environments ?? Environments(),
        this.kuzzleindexes = kuzzleindexes ?? KuzzleIndexes(),
        this.kuzzleping = kuzzleping ?? KuzzlePing();

  Map<String, dynamic> toJson() => {
        'environments': environments.toJson(),
        'kuzzleindexes': kuzzleindexes.toJson(),
        'kuzzleping': kuzzleping.toJson(),
      };

  @override
  String toString() => jsonEncode(toJson());
}
