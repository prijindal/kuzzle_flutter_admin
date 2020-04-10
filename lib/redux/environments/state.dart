import 'package:meta/meta.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';

@immutable
class Environments {
  // Get environments
  final Map<String, Environment> environments;
  // Get default environment name
  final String defaultEnvironment;

  final bool isInitialized;

  Environments({
    this.environments = const {},
    this.defaultEnvironment,
    this.isInitialized = false,
  });

  Environments copyWith({
    Map<String, Environment> environments,
    String defaultEnvironment,
    bool isInitialized,
  }) {
    return Environments(
      environments: environments ?? this.environments,
      defaultEnvironment: defaultEnvironment ?? this.defaultEnvironment,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  // Get default environment name
  Environment get getDefaultEnvironment {
    return getEnvironment(defaultEnvironment);
  }

  // Get single environment
  Environment getEnvironment(String name) {
    if (environments.containsKey(name)) {
      return environments[name];
    } else {
      return null;
    }
  }
}
