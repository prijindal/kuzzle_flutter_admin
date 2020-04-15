import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:redux/redux.dart';
import 'events.dart';

class KuzzlePingError extends Error {
  KuzzlePingError(this.error);
  final String error;
}

Future<void> initKuzzlePing(Store<dynamic> store) async {
  store.dispatch(InitKuzzlePingAction());
  try {
    await FlutterKuzzle.instance.connect();
    final nowServer = await FlutterKuzzle.instance.server.now();
    final now = DateTime.now();
    final difference = now.difference(nowServer);
    if (difference.inMinutes > 10) {
      throw KuzzlePingError(
          'Server is desyncronized with ${difference.inMinutes} minutes');
    }
    store.dispatch(InitSuccessKuzzlePingAction());
  } catch (e) {
    store.dispatch(
      InitErroredKuzzlePingAction(
        e.toString(),
      ),
    );
    store.dispatch(InitKuzzlePingAction());
  }
}
