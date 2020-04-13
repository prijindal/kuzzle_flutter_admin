import 'package:kuzzle/kuzzle.dart';

bool initKuzzleIndex() {
  if (FlutterKuzzle.instance != null) {
    if (FlutterKuzzle.instance.index == null) {
      FlutterKuzzle.instance.index = IndexController(FlutterKuzzle.instance);
    }
    if (FlutterKuzzle.instance.collection == null) {
      FlutterKuzzle.instance.collection =
          CollectionController(FlutterKuzzle.instance);
    }
    if (FlutterKuzzle.instance.security == null) {
      FlutterKuzzle.instance.security =
          SecurityController(FlutterKuzzle.instance);
    }
    return true;
  }
  return false;
}

class FlutterKuzzle extends Kuzzle {
  FlutterKuzzle(
    KuzzleProtocol protocol, {
    bool autoQueue = true,
    bool autoReplay = true,
    bool autoResubscribe = true,
    int eventTimeout = 200,
    OfflineMode offlineMode = OfflineMode.manual,
    Function offlineQueueLoader,
    Function queueFilter,
    Duration queueTTL,
    int queueMaxSize = 500,
    Duration replayInterval,
    Map<String, dynamic> globalVolatile,
  }) : super(
          protocol,
          autoQueue: autoQueue,
          autoReplay: autoReplay,
          autoResubscribe: autoResubscribe,
          eventTimeout: eventTimeout,
          offlineMode: offlineMode,
          offlineQueueLoader: offlineQueueLoader,
          queueFilter: queueFilter,
          queueTTL: queueTTL,
          queueMaxSize: queueMaxSize,
          replayInterval: replayInterval,
          globalVolatile: globalVolatile,
        );

  static FlutterKuzzle instance;
}
