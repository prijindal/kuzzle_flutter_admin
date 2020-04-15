import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'profileevents.dart';

Future<void> getKuzzleProfiles(Store<dynamic> store) async {
  store.dispatch(GetKuzzleProfilesAction());
  if (initKuzzleIndex()) {
    try {
      final profileSearchResult =
          await FlutterKuzzle.instance.security.searchProfiles();
      final profiles = <KuzzleSecurityProfile>[];
      for (final hit in profileSearchResult.hits as List<KuzzleProfile>) {
        profiles.add(
          KuzzleSecurityProfile(
            uid: hit.uid,
            policies: hit.policies,
          ),
        );
      }
      store.dispatch(
        GetSuccessKuzzleProfilesAction(
          profiles,
        ),
      );
    } catch (e) {
      store.dispatch(
        GetErroredKuzzleProfilesAction(
          e.toString(),
        ),
      );
    }
  }
}

ThunkAction<dynamic> getKuzzleProfile(String uid) => (store) async {
      store.dispatch(GetKuzzleProfileAction(uid));
      if (initKuzzleIndex()) {
        try {
          final kuzzleProfile =
              await FlutterKuzzle.instance.security.getProfile(uid);
          store.dispatch(
            GetSuccessKuzzleProfileAction(
              uid,
              KuzzleSecurityProfile(
                uid: kuzzleProfile.uid,
                policies: kuzzleProfile.policies,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            GetErroredKuzzleProfileAction(
              uid,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> addKuzzleProfile(KuzzleSecurityProfile profile) =>
    (store) async {
      store.dispatch(AddKuzzleProfileAction(profile));
      if (initKuzzleIndex()) {
        try {
          final kuzzleProfile = await FlutterKuzzle.instance.security
              .createProfile(
                  profile.uid, profile.policies as List<Map<String, dynamic>>);
          store.dispatch(
            AddSuccessKuzzleProfileAction(
              KuzzleSecurityProfile(
                uid: kuzzleProfile.uid,
                policies: kuzzleProfile.policies,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            AddErroredKuzzleProfileAction(
              profile,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> deleteKuzzleProfile(String uid) => (store) async {
      store.dispatch(DeleteKuzzleProfileAction(uid));
      if (initKuzzleIndex()) {
        try {
          final kuzzleProfile =
              await FlutterKuzzle.instance.security.deleteProfile(uid);
          store.dispatch(
            DeleteSuccessKuzzleProfileAction(kuzzleProfile['_id'] as String),
          );
        } catch (e) {
          store.dispatch(
            DeleteErroredKuzzleProfileAction(
              uid,
              e.toString(),
            ),
          );
        }
      }
    };

ThunkAction<dynamic> editKuzzleProfile(KuzzleSecurityProfile profile) =>
    (store) async {
      store.dispatch(SaveKuzzleProfileAction(profile.uid, profile));
      if (initKuzzleIndex()) {
        try {
          final kuzzleProfile = await FlutterKuzzle.instance.security
              .updateProfile(profile.uid, profile.policies);
          store.dispatch(
            SaveSuccessKuzzleProfileAction(
              kuzzleProfile.uid,
              KuzzleSecurityProfile(
                uid: kuzzleProfile.uid,
                policies: kuzzleProfile.policies,
              ),
            ),
          );
        } catch (e) {
          store.dispatch(
            SaveErroredKuzzleProfileAction(
              profile.uid,
              e.toString(),
            ),
          );
        }
      }
    };
