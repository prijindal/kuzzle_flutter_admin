import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/userevents.dart';

KuzzleSecurityUser kuzzleSecurityUserReducer(
    KuzzleSecurityUser partialState, action) {
  if (partialState == null) {
    partialState = KuzzleSecurityUser(uid: null);
  }
  if (action is GetKuzzleUserAction && action.uid == partialState.uid) {
    return partialState.copyWith(
      loadingState: KuzzleState.LOADING,
    );
  } else if (action is GetSuccessKuzzleUserAction &&
      action.uid == partialState.uid) {
    return partialState.copyWith(
      loadingState: KuzzleState.LOADED,
      uid: action.user.uid,
      content: action.user.content,
      meta: action.user.meta,
    );
  } else if (action is GetErroredKuzzleUserAction &&
      action.uid == partialState.uid) {
    return partialState.copyWith(
      loadingState: KuzzleState.ERRORED,
      loadingError: action.errorMessage,
    );
  } else if (action is SaveKuzzleUserAction && action.uid == partialState.uid) {
    return partialState.copyWith(
      savingState: KuzzleState.LOADING,
    );
  } else if (action is SaveSuccessKuzzleUserAction &&
      action.uid == partialState.uid) {
    return partialState.copyWith(
      savingState: KuzzleState.LOADED,
      content: action.user.content,
      meta: action.user.meta,
    );
  } else if (action is SaveErroredKuzzleUserAction &&
      action.uid == partialState.uid) {
    return partialState.copyWith(
      savingState: KuzzleState.ERRORED,
      savingError: action.errorMessage,
    );
  }
  return partialState;
}

KuzzleSecurity kuzzleSecurityReducer(KuzzleSecurity state, action) {
  if (state == null) {
    state = KuzzleSecurity();
  }
  if (action is GetKuzzleUsersAction) {
    return state.copyWith(
      users: state.users.copyWith(
        loadingState: KuzzleState.LOADING,
      ),
    );
  } else if (action is GetSuccessKuzzleUsersAction) {
    return state.copyWith(
      users: state.users.copyWith(
        loadingState: KuzzleState.LOADED,
        users: action.users,
      ),
    );
  } else if (action is GetErroredKuzzleUsersAction) {
    return state.copyWith(
      users: state.users.copyWith(
        loadingState: KuzzleState.ERRORED,
        loadingError: action.errorMessage,
      ),
    );
  } else if (action is GetKuzzleUserAction ||
      action is GetSuccessKuzzleUserAction ||
      action is GetErroredKuzzleUserAction ||
      action is SaveKuzzleUserAction ||
      action is SaveSuccessKuzzleUserAction ||
      action is SaveErroredKuzzleUserAction) {
    List<KuzzleSecurityUser> users = <KuzzleSecurityUser>[];
    users.addAll(state.users.users);
    users =
        users.map((user) => kuzzleSecurityUserReducer(user, action)).toList();
    return state.copyWith(
      users: state.users.copyWith(
        users: users,
      ),
    );
  } else if (action is AddKuzzleUserAction) {
    return state.copyWith(
      users: state.users.copyWith(
        addingState: KuzzleState.LOADING,
      ),
    );
  } else if (action is AddSuccessKuzzleUserAction) {
    List<KuzzleSecurityUser> users = <KuzzleSecurityUser>[];
    users.addAll(state.users.users);
    users.add(action.user);
    return state.copyWith(
      users: state.users.copyWith(
        addingState: KuzzleState.LOADED,
        users: users,
      ),
    );
  } else if (action is AddErroredKuzzleUserAction) {
    return state.copyWith(
      users: state.users.copyWith(
        addingState: KuzzleState.ERRORED,
        addingError: action.errorMessage,
      ),
    );
  } else if (action is DeleteKuzzleUserAction) {
    return state.copyWith(
      users: state.users.copyWith(
        deletingState: KuzzleState.LOADING,
      ),
    );
  } else if (action is DeleteSuccessKuzzleUserAction) {
    return state.copyWith(
      users: state.users.copyWith(
        deletingState: KuzzleState.LOADED,
        users:
            state.users.users.where((user) => user.uid != action.uid).toList(),
      ),
    );
  } else if (action is DeleteErroredKuzzleUserAction) {
    return state.copyWith(
      users: state.users.copyWith(
        deletingState: KuzzleState.ERRORED,
        deletingError: action.errorMessage,
      ),
    );
  }
  return state;
}
