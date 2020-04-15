import 'dart:convert';

import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/models/kuzzleauth.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzleping.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  const AppState({
    Environments environments,
    KuzzleIndexes kuzzleindexes,
    KuzzlePing kuzzleping,
    KuzzleSecurity kuzzlesecurity,
    KuzzleAuth kuzzleauth,
  })  : this.environments = environments ?? const Environments(),
        this.kuzzleindexes = kuzzleindexes ?? const KuzzleIndexes(),
        this.kuzzleping = kuzzleping ?? const KuzzlePing(),
        this.kuzzlesecurity = kuzzlesecurity ?? const KuzzleSecurity(),
        this.kuzzleauth = kuzzleauth ?? const KuzzleAuth();

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
