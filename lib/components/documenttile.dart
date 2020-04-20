import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/models/document.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';

class DocumentListTile extends StatelessWidget {
  const DocumentListTile({
    @required this.index,
    @required this.collection,
    this.document,
  });

  final KuzzleCollection collection;
  final String index;
  final KuzzleDocument document;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(document.id),
      );
}
