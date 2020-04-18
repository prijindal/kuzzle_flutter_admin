import 'package:meta/meta.dart';

import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kuzzleauth.g.dart';

@JsonSerializable()
@immutable
class KuzzleAuth {
  const KuzzleAuth({
    this.token,
    this.loginState = KuzzleState.INIT,
    this.logoutState = KuzzleState.INIT,
    this.adminCheckState = KuzzleState.INIT,
    this.loginError,
    this.logoutError,
    this.adminCheckError,
    this.adminCheckResult,
  });

  factory KuzzleAuth.fromJson(Map<String, dynamic> json) =>
      _$KuzzleAuthFromJson(json);

  final KuzzleState loginState;
  final KuzzleState logoutState;
  final KuzzleState adminCheckState;
  final String loginError;
  final String logoutError;
  final String adminCheckError;
  final String token;
  final bool adminCheckResult;

  bool get isAuthenticated {
    if (loginState == KuzzleState.LOADED && token.isNotEmpty) {
      return true;
    }
    return false;
  }

  KuzzleAuth copyWith({
    KuzzleState loginState,
    KuzzleState logoutState,
    KuzzleState adminCheckState,
    String token,
    String loginError,
    String logoutError,
    String adminCheckError,
    bool adminCheckResult,
  }) =>
      KuzzleAuth(
        loginState: loginState ?? this.loginState,
        logoutState: logoutState ?? this.logoutState,
        adminCheckState: adminCheckState ?? this.adminCheckState,
        loginError: loginError ?? this.loginError,
        logoutError: logoutError ?? this.logoutError,
        adminCheckError: adminCheckError ?? this.adminCheckError,
        token: token ?? this.token,
        adminCheckResult: adminCheckResult ?? this.adminCheckResult,
      );

  Map<String, dynamic> toJson() => _$KuzzleAuthToJson(this);
}
