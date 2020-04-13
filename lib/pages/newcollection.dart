import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/index.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class NewCollectionPageRouteArguments {
  final String index;
  NewCollectionPageRouteArguments({@required this.index});
}

class NewCollectionPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => NewCollectionPage(
        index: (ModalRoute.of(context).settings.arguments
                as NewCollectionPageRouteArguments)
            .index,
      );
}

class NewCollectionPage extends StatefulWidget {
  final String index;
  NewCollectionPage({@required this.index});

  _NewCollectionPageState createState() => _NewCollectionPageState();
}

class _NewCollectionPageState extends State<NewCollectionPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _checkingAdded = false;

  @override
  void didChangeDependencies() {
    _checkAdded();
    super.didChangeDependencies();
  }

  bool _checkAdded() {
    if (_kuzzleIndex.addingState == KuzzleState.LOADED &&
        _checkingAdded == true) {
      setState(() {
        _checkingAdded = false;
      });
      Navigator.of(context).pushReplacementNamed(
        "collections",
        arguments: CollectionsPageRouteArguments(index: widget.index),
      );
      return true;
    }
    return false;
  }

  void _addNewCollection() {
    StoreProvider.of<AppState>(context).dispatch(
      addKuzzleCollection(
        widget.index,
        KuzzleCollection(name: _nameController.text),
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

  KuzzleIndex get _kuzzleIndex {
    if (StoreProvider.of<AppState>(context)
        .state
        .kuzzleindexes
        .indexMap
        .containsKey(widget.index)) {
      return StoreProvider.of<AppState>(context)
          .state
          .kuzzleindexes
          .indexMap[widget.index];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: '${widget.index}/Create a new collection',
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
                  onPressed: _kuzzleIndex.addingState == KuzzleState.LOADING
                      ? null
                      : _addNewCollection,
                ),
              ),
              if (_kuzzleIndex.addingState == KuzzleState.LOADING ||
                  _kuzzleIndex.addingState == KuzzleState.LOADED)
                Center(
                  child: Text(_kuzzleIndex.addingState == KuzzleState.LOADING
                      ? "Loading"
                      : "Added Succesfully"),
                )
            ],
          ),
        ),
      );
}
