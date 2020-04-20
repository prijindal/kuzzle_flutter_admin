import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/pages/documentsbrowse.dart';
import 'package:kuzzleflutteradmin/pages/documentswatch.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({
    @required this.index,
    @required this.collection,
  });

  final KuzzleCollection collection;
  final String index;

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: '${widget.index}/${widget.collection.name}/Documents',
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Browse', icon: Icon(Icons.library_books)),
            Tab(text: 'Watch', icon: Icon(Icons.view_stream)),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BrowseDocumentsTabPage(
              index: widget.index,
              collection: widget.collection,
            ),
            WatchDocumentsTabPage(
              index: widget.index,
              collection: widget.collection,
            ),
          ],
        ),
      );
}
