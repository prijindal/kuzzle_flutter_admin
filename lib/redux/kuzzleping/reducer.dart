import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';

import 'state.dart';
import 'events.dart';

KuzzlePing kuzzlePingReducer(KuzzlePing state, action) {
  if (state == null) {
    state = KuzzlePing();
  }
  if (action is InitKuzzlePingAction) {
    return state.copyWith(
      loadingState: KuzzleState.LOADING,
    );
  } else if (action is InitSuccessKuzzlePingAction) {
    return state.copyWith(
      errorMessage: null,
      loadingState: KuzzleState.LOADED,
    );
  } else if (action is InitErroredKuzzlePingAction) {
    return state.copyWith(
      errorMessage: action.errorMessage,
      loadingState: KuzzleState.ERRORED,
    );
  }
  return state;
}
