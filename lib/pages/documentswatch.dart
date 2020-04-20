import 'package:flutter/material.dart';
import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/documenttile.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
import 'package:kuzzleflutteradmin/models/document.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';

class WatchDocumentsTabPage extends StatefulWidget {
  const WatchDocumentsTabPage({
    @required this.index,
    @required this.collection,
  });

  final KuzzleCollection collection;
  final String index;

  @override
  _WatchDocumentsTabPageState createState() => _WatchDocumentsTabPageState();
}

class _WatchDocumentsTabPageState extends State<WatchDocumentsTabPage> {
  Map<String, dynamic> _filters = <String, dynamic>{};
  List<KuzzleDocument> _results = [];
  String _roomId;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initSubscription() async {
    setState(() {
      _isLoading = true;
    });
    final roomId = await FlutterKuzzle.instance.realtime
        .subscribe(widget.index, widget.collection.name, _filters, (response) {
      setState(() {
        _results.add(
          KuzzleDocument.fromJson(response.result as Map<String, dynamic>),
        );
      });
    });
    setState(() {
      _roomId = roomId;
      _isLoading = false;
    });
  }

  void _unSubscribe() {
    if (_roomId != null && mounted == true) {
      FlutterKuzzle.instance.realtime.unsubscribe(_roomId);
      setState(() {
        _roomId = null;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unSubscribe();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        primary: false,
        floatingActionButton: FloatingActionButton(
          child: Icon(_roomId == null ? Icons.play_arrow : Icons.stop),
          onPressed: _roomId == null ? _initSubscription : _unSubscribe,
        ),
        body: _isLoading == true
            ? const LoadingAnimation()
            : _roomId == null
                ? Center(
                    child: Text(
                      'You did not subscribe yet to ${widget.collection.name}',
                    ),
                  )
                : AnimatedListView(
                    shrinkWrap: true,
                    itemCount: _results.length,
                    itemBuilder: (context, i) => DocumentListTile(
                      document: _results[i],
                      index: widget.index,
                      collection: widget.collection,
                    ),
                  ),
      );
}
