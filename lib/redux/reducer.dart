import 'package:kuzzleflutteradmin/redux/kuzzleping/reducer.dart';

import 'environments/index.dart';
import 'kuzzleindex/index.dart';
import 'state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    environments: environmentsReducer(state.environments, action),
    kuzzleindexes: kuzzleReducer(state.kuzzleindexes, action),
    kuzzleping: kuzzlePingReducer(state.kuzzleping, action),
  );
}
