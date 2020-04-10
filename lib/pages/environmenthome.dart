import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';

class EnvironmentHomePage extends StatelessWidget {
  final Environment environment;
  EnvironmentHomePage(this.environment);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(environment.host),
        ),
        body: Center(
          child: Text(environment.host),
        ),
      );
}
