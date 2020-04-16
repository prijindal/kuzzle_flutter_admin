import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/events.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class NewIndexPage extends StatefulWidget {
  @override
  _NewIndexPageState createState() => _NewIndexPageState();
}

class _NewIndexPageState extends State<NewIndexPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _checkingAdded = false;

  void _addNewIndex() {
    StoreProvider.of<AppState>(context).dispatch(
      addKuzzleIndex(
        _nameController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, KuzzleIndexes>(
        onInit: (store) {
          store.dispatch(InitAddKuzzleIndexAction());
        },
        onWillChange: (_, newvalue) {
          if (newvalue.addingState == KuzzleState.LOADED &&
              _checkingAdded == false) {
            setState(() {
              _checkingAdded = true;
            });
            Navigator.of(context).pushReplacementNamed('indexes');
          }
        },
        converter: (store) => store.state.kuzzleindexes,
        builder: (context, kuzzleindexes) => ResponsiveScaffold(
          subtitle: 'Add new Index',
          body: Form(
            child: AnimatedColumn(
              children: [
                TextFormField(
                  controller: _nameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    child: const Text('Create'),
                    onPressed: kuzzleindexes.addingState == KuzzleState.LOADING
                        ? null
                        : _addNewIndex,
                  ),
                ),
                if (kuzzleindexes.addingState == KuzzleState.LOADING)
                  const LoadingAnimation()
              ],
            ),
          ),
        ),
      );
}
