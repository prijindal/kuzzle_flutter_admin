import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/pages/environmenthome.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class EnvironmentsPage extends StatelessWidget {
  const EnvironmentsPage({Key key}) : super(key: key);

  void _goToAddEnvironmentPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('addenvironment');
  }

  Future<void> _deleteEnvironmentConfirm(
      String name, BuildContext context) async {
    final confirm = await confirmDialog(context, 'Delete $name',
        'Are you sure you want to delete this environment');
    if (confirm) {
      StoreProvider.of<AppState>(context)
          .dispatch(RemoveEnvironmentAction(name));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Environments'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _goToAddEnvironmentPage(context),
        ),
        body: Scaffold(
          body: StoreConnector<AppState, Map<String, Environment>>(
            converter: (store) => store.state.environments.environments,
            builder: (context, environments) => AnimatedListView(
              itemCount: environments.length,
              itemBuilder: (context, i) => ListTile(
                onTap: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    EditEnvironmentAction(
                      StoreProvider.of<AppState>(context)
                          .state
                          .environments
                          .defaultEnvironment,
                      Environment(
                        name: StoreProvider.of<AppState>(context)
                            .state
                            .environments
                            .defaultEnvironment,
                        token: '',
                      ),
                    ),
                  );
                  StoreProvider.of<AppState>(context).dispatch(
                      SetDefaultEnvironmentAction(
                          environments.keys.elementAt(i)));
                  Navigator.of(context).pushNamed(
                    'environment',
                    arguments: EnvironmentHomePageRouteArguments(
                      environment: environments[environments.keys.elementAt(i)],
                    ),
                  );
                },
                title: Text(environments.keys.elementAt(i)),
                subtitle: Text(
                    '${environments[environments.keys.elementAt(i)].ssl ? 'wss' : 'ws'}://${environments[environments.keys.elementAt(i)].host}:${environments[environments.keys.elementAt(i)].port}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteEnvironmentConfirm(
                      environments.keys.elementAt(i), context),
                ),
              ),
            ),
          ),
        ),
      );
}
