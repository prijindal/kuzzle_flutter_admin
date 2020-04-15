abstract class KuzzleAuthAction {}

class LoginKuzzleAuthAction extends KuzzleAuthAction {}

class LoginSuccessKuzzleAuthAction extends KuzzleAuthAction {
  LoginSuccessKuzzleAuthAction(this.jwt);
  final String jwt;
}

class LoginErroredKuzzleAuthAction extends KuzzleAuthAction {
  LoginErroredKuzzleAuthAction(this.errorMessage);
  final String errorMessage;
}

class LogoutKuzzleAuthAction extends KuzzleAuthAction {}

class LogoutSuccessKuzzleAuthAction extends KuzzleAuthAction {}

class LogoutErroredKuzzleAuthAction extends KuzzleAuthAction {
  LogoutErroredKuzzleAuthAction(this.errorMessage);
  final String errorMessage;
}
