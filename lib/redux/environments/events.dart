import 'package:kuzzleflutteradmin/models/environment.dart';

abstract class EnvironmentAction {}

class InitializeEnvironmentAction extends EnvironmentAction {}

class InitializeSuccessEnvironmentAction extends EnvironmentAction {
  InitializeSuccessEnvironmentAction(
    this.environments,
    this.defaultEnvironments,
  );
  Map<String, Environment> environments;
  String defaultEnvironments;
}

class AddEnvironmentAction extends EnvironmentAction {
  AddEnvironmentAction(this.environment);
  Environment environment;
}

class EditEnvironmentAction extends EnvironmentAction {
  EditEnvironmentAction(this.environmentName, this.environment);
  String environmentName;
  Environment environment;
}

class RemoveEnvironmentAction extends EnvironmentAction {
  RemoveEnvironmentAction(this.environmentName);
  String environmentName;
}

class SetDefaultEnvironmentAction extends EnvironmentAction {
  SetDefaultEnvironmentAction(this.environmentName);
  String environmentName;
}

class SetFirstEnvironmentAction extends EnvironmentAction {
  SetFirstEnvironmentAction(this.environment);
  Environment environment;
}
