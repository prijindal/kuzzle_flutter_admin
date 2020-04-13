import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';

part 'kuzzleping.g.dart';

@JsonSerializable()
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

  factory KuzzlePing.fromJson(Map<String, dynamic> json) =>
      _$KuzzlePingFromJson(json);

  Map<String, dynamic> toJson() => _$KuzzlePingToJson(this);
}
