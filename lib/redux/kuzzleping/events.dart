abstract class KuzzlePingAction {}

class InitKuzzlePingAction extends KuzzlePingAction {}

class InitSuccessKuzzlePingAction extends KuzzlePingAction {}

class InitErroredKuzzlePingAction extends KuzzlePingAction {
  InitErroredKuzzlePingAction(this.errorMessage);
  final String errorMessage;
}
