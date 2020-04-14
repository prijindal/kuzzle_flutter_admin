import 'package:kuzzleflutteradmin/redux/environments/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleping/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/reducer.dart';

import 'state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    environments: environmentsReducer(state.environments, action),
    kuzzleindexes: kuzzleReducer(state.kuzzleindexes, action),
    kuzzleping: kuzzlePingReducer(state.kuzzleping, action),
    kuzzlesecurity: kuzzleSecurityReducer(state.kuzzlesecurity, action),
    kuzzleauth: authReducer(state.kuzzleauth, action),
  );
}
