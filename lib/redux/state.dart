import 'dart:convert';

import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/models/kuzzleauth.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzleping.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    Environments environments,
    KuzzleIndexes kuzzleindexes,
    KuzzlePing kuzzleping,
    KuzzleSecurity kuzzlesecurity,
    KuzzleAuth kuzzleauth,
  })  : this.environments = environments ?? Environments(),
        this.kuzzleindexes = kuzzleindexes ?? KuzzleIndexes(),
        this.kuzzleping = kuzzleping ?? KuzzlePing(),
        this.kuzzlesecurity = kuzzlesecurity ?? KuzzleSecurity(),
        this.kuzzleauth = kuzzleauth ?? KuzzleAuth();

  final Environments environments;
  final KuzzleIndexes kuzzleindexes;
  final KuzzlePing kuzzleping;
  final KuzzleSecurity kuzzlesecurity;
  final KuzzleAuth kuzzleauth;

  Map<String, dynamic> toJson() => {
        'environments': environments.toJson(),
        'kuzzleindexes': kuzzleindexes.toJson(),
        'kuzzleping': kuzzleping.toJson(),
        'kuzzlesecurity': kuzzlesecurity.toJson(),
        'kuzzleauth': kuzzleauth.toJson(),
      };

  @override
  String toString() {
    const encoder = JsonEncoder();
    return encoder.convert(toJson());
  }
}
