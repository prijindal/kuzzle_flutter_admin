import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'userevents.dart';

void getKuzzleUsers(Store<dynamic> store) async {
  store.dispatch(GetKuzzleUsersAction());
  if (initKuzzleIndex()) {
    try {
      var userSearchResult =
          await FlutterKuzzle.instance.security.searchUsers();
      print(userSearchResult);
      store.dispatch(
        GetSuccessKuzzleUsersAction(
          userSearchResult.hits,
        ),
      );
    } catch (e) {
      store.dispatch(
        GetErroredKuzzleUsersAction(
          e.toString(),
        ),
      );
    }
  }
}
