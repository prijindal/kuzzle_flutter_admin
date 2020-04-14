import 'package:meta/meta.dart';

import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kuzzleauth.g.dart';

@JsonSerializable()
@immutable
class KuzzleAuth {
  final KuzzleState loginState;
  final KuzzleState logoutState;
  final String loginError;
  final String logoutError;
  final String token;

  bool get isAuthenticated {
    if (loginState == KuzzleState.LOADED && token.isNotEmpty) {
      return true;
    }
    return false;
  }

  KuzzleAuth({
    this.token,
    this.loginState = KuzzleState.INIT,
    this.logoutState = KuzzleState.INIT,
    this.loginError,
    this.logoutError,
  });

  KuzzleAuth copyWith({
    KuzzleState loginState,
    KuzzleState logoutState,
    String token,
    String loginError,
    String logoutError,
  }) {
    return KuzzleAuth(
      loginState: loginState ?? this.loginState,
      logoutState: logoutState ?? this.logoutState,
      loginError: loginError ?? this.loginError,
      logoutError: logoutError ?? this.logoutError,
      token: token ?? this.token,
    );
  }

  factory KuzzleAuth.fromJson(Map<String, dynamic> json) =>
      _$KuzzleAuthFromJson(json);

  Map<String, dynamic> toJson() => _$KuzzleAuthToJson(this);
}
