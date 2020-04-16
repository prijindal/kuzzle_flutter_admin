import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'userevents.dart';

Future<void> getKuzzleUsers(Store<dynamic> store) async {
  store.dispatch(GetKuzzleUsersAction());
  if (initKuzzleIndex()) {
    try {
      final userSearchResult =
          await FlutterKuzzle.instance.security.searchUsers();
      final users = <KuzzleSecurityUser>[];
      for (var hit in userSearchResult.hits) {
        users.add(
          KuzzleSecurityUser(
            uid: (hit as KuzzleUser).uid,
            content: (hit as KuzzleUser).content,
            meta: (hit as KuzzleUser).meta,
          ),
        );
      }
      store.dispatch(
        GetSuccessKuzzleUsersAction(
          users,
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

ThunkAction<dynamic> getKuzzleUser(String uid) => (store) async {
      store.dispatch(GetKuzzleUserAction(uid));
      if (initKuzzleIndex()) {
        try {
          final kuzzleUser = await FlutterKuzzle.instance.security.getUser(uid);
          store.dispatch(
            GetSuccessKuzzleUserAction(
              uid,
              KuzzleSecurityUser(
                uid: kuzzleUser.uid,
                content: kuzzleUser.content,
                meta: kuzzleUser.meta,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            GetErroredKuzzleUserAction(
              uid,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> addKuzzleUser(
        KuzzleSecurityUser user, Map<String, dynamic> credentials) =>
    (store) async {
      store.dispatch(AddKuzzleUserAction(user));
      if (initKuzzleIndex()) {
        try {
          final kuzzleUser = await FlutterKuzzle.instance.security.createUser(
            credentials,
            user.content,
            uid: user.uid,
          );
          store.dispatch(
            AddSuccessKuzzleUserAction(
              KuzzleSecurityUser(
                uid: kuzzleUser.uid,
                content: kuzzleUser.content,
                meta: kuzzleUser.meta,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            AddErroredKuzzleUserAction(
              user,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> deleteKuzzleUser(String uid) => (store) async {
      store.dispatch(DeleteKuzzleUserAction(uid));
      if (initKuzzleIndex()) {
        try {
          final kuzzleUser =
              await FlutterKuzzle.instance.security.deleteUser(uid);
          store.dispatch(
            DeleteSuccessKuzzleUserAction(kuzzleUser['_id'] as String),
          );
        } catch (e) {
          store.dispatch(
            DeleteErroredKuzzleUserAction(
              uid,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> editKuzzleUser(KuzzleSecurityUser user) => (store) async {
      store.dispatch(SaveKuzzleUserAction(user.uid, user));
      if (initKuzzleIndex()) {
        try {
          final kuzzleUser = await FlutterKuzzle.instance.security
              .updateUser(user.content, uid: user.uid);
          store.dispatch(
            SaveSuccessKuzzleUserAction(
              kuzzleUser.uid,
              KuzzleSecurityUser(
                uid: kuzzleUser.uid,
                content: kuzzleUser.content,
                meta: kuzzleUser.meta,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            SaveErroredKuzzleUserAction(
              user.uid,
              e.toString(),
            ),
          );
        }
      }
    };
