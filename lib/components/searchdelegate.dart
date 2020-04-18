import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';

class KuzzleSearchDelegate<T> extends SearchDelegate<T> {
  KuzzleSearchDelegate({
    @required this.getResults,
    @required this.getSuggestions,
    @required this.itemBuilder,
  });

  final Future<List<T>> Function(String query) getResults;
  final List<String> Function(String query) getSuggestions;
  final Widget Function(T item) itemBuilder;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    final resultFuture = getResults(query);
    return FutureBuilder<List<T>>(
      future: resultFuture,
      builder: (context, asyncSnapshot) => !asyncSnapshot.hasData
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoadingAnimation(),
              ],
            )
          : AnimatedListView(
              shrinkWrap: true,
              itemBuilder: (context, i) => itemBuilder(asyncSnapshot.data[i]),
              itemCount: asyncSnapshot.data.length,
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = getSuggestions(query);
    if (suggestions == null || suggestions.isEmpty) {
      return Column();
    }
    return AnimatedListView(
      itemBuilder: (context, i) => ListTile(
        title: Text(suggestions[i]),
      ),
      itemCount: suggestions.length,
    );
  }
}
