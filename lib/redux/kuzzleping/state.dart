import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:meta/meta.dart';

@immutable
class KuzzlePing {
  final String errorMessage;
  final KuzzleState loadingState;

  KuzzlePing({
    this.errorMessage,
    this.loadingState = KuzzleState.INIT,
  });

  KuzzlePing copyWith({
    String errorMessage,
    KuzzleState loadingState,
  }) {
    return KuzzlePing(
      errorMessage: errorMessage ?? this.errorMessage,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  Map<String, dynamic> toJson() => {
        'errorMessage': errorMessage,
        'loadingState': loadingState.toString(),
      };
}
