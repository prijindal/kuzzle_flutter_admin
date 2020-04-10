import 'package:kuzzle/kuzzle.dart';

class FlutterKuzzle extends Kuzzle {
  FlutterKuzzle(
    KuzzleProtocol protocol, {
    bool autoQueue,
    bool autoReplay,
    bool autoResubscribe,
    int eventTimeout,
    OfflineMode offlineMode,
    Function offlineQueueLoader,
    Function queueFilter,
    Duration queueTTL,
    int queueMaxSize,
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
