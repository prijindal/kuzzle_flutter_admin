abstract class KuzzlePingAction {}

class InitKuzzlePingAction extends KuzzlePingAction {}

class InitSuccessKuzzlePingAction extends KuzzlePingAction {}

class InitErroredKuzzlePingAction extends KuzzlePingAction {
  final String errorMessage;
  InitErroredKuzzlePingAction(this.errorMessage);
}
