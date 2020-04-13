import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class NewIndexPage extends StatefulWidget {
  _NewIndexPageState createState() => _NewIndexPageState();
}

class _NewIndexPageState extends State<NewIndexPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _checkingAdded = false;
  KuzzleState get _addingState =>
      StoreProvider.of<AppState>(context).state.kuzzleindexes.addingState;

  @override
  void didChangeDependencies() {
    _checkAdded();
    super.didChangeDependencies();
  }

  bool _checkAdded() {
    if (_addingState == KuzzleState.LOADED && _checkingAdded == true) {
      setState(() {
        _checkingAdded = false;
      });
      Navigator.of(context).pushReplacementNamed("indexes");
      return true;
    }
    return false;
  }

  void _addNewIndex() {
    StoreProvider.of<AppState>(context).dispatch(
      addKuzzleIndex(
        _nameController.text,
      ),
    );
    setState(() {
      _checkingAdded = true;
    });
    new Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_checkAdded() == true) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: "Add new Index",
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text("Create"),
                  onPressed:
                      _addingState == KuzzleState.LOADING ? null : _addNewIndex,
                ),
              ),
              if (_addingState == KuzzleState.LOADING ||
                  _addingState == KuzzleState.LOADED)
                Center(
                  child: Text(_addingState == KuzzleState.LOADING
                      ? "Loading"
                      : "Added Succesfully"),
                )
            ],
          ),
        ),
      );
}
