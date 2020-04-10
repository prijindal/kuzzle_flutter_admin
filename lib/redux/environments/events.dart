import 'package:kuzzleflutteradmin/models/environment.dart';

abstract class EnvironmentAction {}

class InitializeEnvironmentAction extends EnvironmentAction {}

class InitializeSuccessEnvironmentAction extends EnvironmentAction {
  Map<String, dynamic> environments;
  String defaultEnvironments;
  InitializeSuccessEnvironmentAction(
      this.environments, this.defaultEnvironments);
}

class AddEnvironmentAction extends EnvironmentAction {
  Environment environment;
  AddEnvironmentAction(this.environment);
}

class RemoveEnvironmentAction extends EnvironmentAction {
  String environmentName;
  RemoveEnvironmentAction(this.environmentName);
}

class SetDefaultEnvironmentAction extends EnvironmentAction {
  String environmentName;
  SetDefaultEnvironmentAction(this.environmentName);
}

class SetFirstEnvironmentAction extends EnvironmentAction {
  Environment environment;
  SetFirstEnvironmentAction(this.environment);
}
