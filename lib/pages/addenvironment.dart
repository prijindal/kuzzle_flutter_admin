import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';
import '../redux/environments/events.dart';

class AddEnvironmentPage extends StatefulWidget {
  @override
  _AddEnvironmentPageState createState() => _AddEnvironmentPageState();
}

class _AddEnvironmentPageState extends State<AddEnvironmentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController =
      TextEditingController(text: '7512');
  bool _sslValue = false;

  void _addNewEnvironment() {
    if (_formKey.currentState.validate()) {
      final environment = Environment(
        name: _nameController.text,
        host: _hostController.text,
        port: int.tryParse(_portController.text),
        ssl: _sslValue,
      );
      if (StoreProvider.of<AppState>(context)
              .state
              .environments
              .getDefaultEnvironment ==
          null) {
        StoreProvider.of<AppState>(context).dispatch(
          SetFirstEnvironmentAction(environment),
        );
      } else {
        StoreProvider.of<AppState>(context).dispatch(
          AddEnvironmentAction(environment),
        );
        StoreProvider.of<AppState>(context).dispatch(
          SetDefaultEnvironmentAction(environment.name),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('New Environment'),
        ),
        body: Form(
          key: _formKey,
          child: AnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a host';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Host'),
                controller: _hostController,
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a port';
                  }
                  final parsed = int.tryParse(value);
                  if (parsed == null) {
                    return 'Port should be an int';
                  }
                  if (parsed < 0 || parsed > 65535) {
                    return 'Port can only be between 0 and 65535';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Port'),
                controller: _portController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
              CheckboxListTile(
                value: _sslValue,
                onChanged: (newvalue) {
                  setState(() {
                    _sslValue = newvalue;
                  });
                },
                title: const Text('Use SSL'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RaisedButton(
                  child: const Text('Create'),
                  onPressed: _addNewEnvironment,
                ),
              ),
            ],
          ),
        ),
      );
}
