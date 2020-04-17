import 'package:kuzzleflutteradmin/models/kuzzleauth.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/events.dart';

KuzzleAuth authReducer(KuzzleAuth state, dynamic action) {
  state ??= const KuzzleAuth();
  if (action is InitKuzzleAuthAction) {
    return state.copyWith(
      loginState: KuzzleState.INIT,
      token: '',
      logoutState: KuzzleState.INIT,
    );
  } else if (action is LoginKuzzleAuthAction) {
    return state.copyWith(
      loginState: KuzzleState.LOADING,
      token: '',
    );
  } else if (action is LoginSuccessKuzzleAuthAction) {
    return state.copyWith(
      loginState: KuzzleState.LOADED,
      token: action.jwt,
    );
  } else if (action is LoginErroredKuzzleAuthAction) {
    return state.copyWith(
      loginState: KuzzleState.ERRORED,
      token: '',
      loginError: action.errorMessage,
    );
  } else if (action is LogoutKuzzleAuthAction) {
    return state.copyWith(
      logoutState: KuzzleState.LOADING,
    );
  } else if (action is LogoutSuccessKuzzleAuthAction) {
    return state.copyWith(
      logoutState: KuzzleState.LOADED,
      token: '',
    );
  } else if (action is LogoutErroredKuzzleAuthAction) {
    return state.copyWith(
      logoutState: KuzzleState.ERRORED,
      logoutError: action.errorMessage,
    );
  }
  return state;
}
