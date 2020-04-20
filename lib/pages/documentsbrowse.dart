import 'package:flutter/material.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/documenttile.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/document.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/pages/newdocumentpage.dart';

class BrowseDocumentsTabPage extends StatefulWidget {
  const BrowseDocumentsTabPage({
    @required this.index,
    @required this.collection,
  });

  final KuzzleCollection collection;
  final String index;

  @override
  _BrowseDocumentsTabPageState createState() => _BrowseDocumentsTabPageState();
}

class _BrowseDocumentsTabPageState extends State<BrowseDocumentsTabPage> {
  DocumentsSearchResult _documentsSearchResult;

  @override
  void initState() {
    super.initState();
    _getDocuments();
  }

  Future<void> _getDocuments() async {
    final documentsSearchResult = await FlutterKuzzle.instance.document
        .search(widget.index, widget.collection.name);
    if (mounted) {
      setState(() {
        _documentsSearchResult = documentsSearchResult;
      });
    }
  }

  Future<void> _refresh() => _getDocuments();

  Future<void> _goToAddDocumentPage(BuildContext context) async {
    await Navigator.of(context).push<KuzzleDocument>(
      MaterialPageRoute(
        builder: (context) => NewDocumentPage(
          index: widget.index,
          collection: widget.collection,
        ),
      ),
    );
    await _refresh();
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          primary: false,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _goToAddDocumentPage(context),
          ),
          body: _documentsSearchResult == null
              ? const LoadingAnimation()
              : AnimatedListView(
                  itemCount: _documentsSearchResult.hits.length,
                  itemBuilder: (context, i) => DocumentListTile(
                    index: widget.index,
                    collection: widget.collection,
                    document: KuzzleDocument.fromJson(
                      _documentsSearchResult.hits[i] as Map<String, dynamic>,
                    ),
                  ),
                ),
        ),
      );
}
