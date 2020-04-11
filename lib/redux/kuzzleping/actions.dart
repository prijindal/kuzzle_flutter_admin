import 'package:flutter/cupertino.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:redux/redux.dart';
import 'events.dart';

void initKuzzlePing(Store<dynamic> store) async {
  store.dispatch(InitKuzzlePingAction());
  try {
    await FlutterKuzzle.instance.connect();
    DateTime nowServer = await FlutterKuzzle.instance.server.now();
    DateTime now = DateTime.now();
    var difference = now.difference(nowServer);
    if (difference.inMinutes > 10) {
      throw new ErrorDescription(
          "Server is desyncronized with ${difference.inMinutes} minutes");
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
