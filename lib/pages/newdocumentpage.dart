import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/documenttile.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/document.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';

class NewDocumentPage extends StatefulWidget {
  const NewDocumentPage({
    @required this.index,
    @required this.collection,
  });

  final KuzzleCollection collection;
  final String index;

  @override
  _NewDocumentPageState createState() => _NewDocumentPageState();
}

class _NewDocumentPageState extends State<NewDocumentPage> {
  final TextEditingController _documentIdentifierController =
      TextEditingController();
  final TextEditingController _sourceController =
      TextEditingController(text: '{}');
  KuzzleState _addingState = KuzzleState.INIT;
  String _addingError;

  Future<void> _addNewDocument() async {
    setState(() {
      _addingState = KuzzleState.LOADING;
    });
    try {
      final result = await FlutterKuzzle.instance.document.create(
        widget.index,
        widget.collection.name,
        jsonDecode(_sourceController.text) as Map<String, dynamic>,
        uid: _documentIdentifierController.text.isEmpty
            ? null
            : _documentIdentifierController.text,
      );
      setState(() {
        _addingState = KuzzleState.LOADED;
      });
      Navigator.of(context)
          .pop<KuzzleDocument>(KuzzleDocument.fromJson(result));
    } catch (e) {
      setState(() {
        _addingState = KuzzleState.ERRORED;
        _addingError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle:
            '${widget.index}/${widget.collection.name}/Create a new document',
        body: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Document identifier(optional)'),
                controller: _documentIdentifierController,
              ),
              Expanded(
                child: TextFormField(
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'New Document'),
                  controller: _sourceController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RaisedButton(
                  child: const Text('Create'),
                  onPressed: _addingState == KuzzleState.LOADING
                      ? null
                      : _addNewDocument,
                ),
              ),
              if (_addingState == KuzzleState.ERRORED)
                Center(
                  child: Text(_addingError),
                ),
              if (_addingState == KuzzleState.LOADING) const LoadingAnimation(),
            ],
          ),
        ),
      );
}
