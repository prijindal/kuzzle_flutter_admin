import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';

part 'kuzzleping.g.dart';

@JsonSerializable()
@immutable
class KuzzlePing {
  const KuzzlePing({
    this.errorMessage,
    this.loadingState = KuzzleState.INIT,
  });

  factory KuzzlePing.fromJson(Map<String, dynamic> json) =>
      _$KuzzlePingFromJson(json);

  final String errorMessage;
  final KuzzleState loadingState;

  KuzzlePing copyWith({
    String errorMessage,
    KuzzleState loadingState,
  }) =>
      KuzzlePing(
        errorMessage: errorMessage ?? this.errorMessage,
        loadingState: loadingState ?? this.loadingState,
      );

  Map<String, dynamic> toJson() => _$KuzzlePingToJson(this);
}
