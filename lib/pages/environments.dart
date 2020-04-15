import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/helpers/confirmdialog.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/redux/environments/events.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class EnvironmentsPage extends StatefulWidget {
  const EnvironmentsPage({Key key}) : super(key: key);

  @override
  _EnvironmentsPageState createState() => _EnvironmentsPageState();
}

class _EnvironmentsPageState extends State<EnvironmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  void _goToAddEnvironmentPage() {
    Navigator.of(context).pushReplacementNamed('addenvironment');
  }

  Future<void> _deleteEnvironmentConfirm(String name) async {
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
          onPressed: _goToAddEnvironmentPage,
        ),
        body: Scaffold(
          body: StoreConnector<AppState, Map<String, Environment>>(
            converter: (store) => store.state.environments.environments,
            builder: (context, environments) => ListView(
              children: environments.keys
                  .map(
                    (environmentName) => ListTile(
                      title: Text(environmentName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _deleteEnvironmentConfirm(environmentName),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
