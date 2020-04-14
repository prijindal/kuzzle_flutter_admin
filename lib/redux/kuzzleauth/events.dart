abstract class KuzzleAuthAction {}

class LoginKuzzleAuthAction extends KuzzleAuthAction {}

class LoginSuccessKuzzleAuthAction extends KuzzleAuthAction {
  final String jwt;
  LoginSuccessKuzzleAuthAction(this.jwt);
}

class LoginErroredKuzzleAuthAction extends KuzzleAuthAction {
  final String errorMessage;
  LoginErroredKuzzleAuthAction(this.errorMessage);
}

class LogoutKuzzleAuthAction extends KuzzleAuthAction {}

class LogoutSuccessKuzzleAuthAction extends KuzzleAuthAction {}

class LogoutErroredKuzzleAuthAction extends KuzzleAuthAction {
  final String errorMessage;
  LogoutErroredKuzzleAuthAction(this.errorMessage);
}
