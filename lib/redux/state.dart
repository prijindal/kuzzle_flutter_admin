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
}
