import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import '../helpers/responsive.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    this.subtitle,
    this.body,
    this.floatingActionButton,
    this.onSearch,
    this.bottom,
  });
  final String subtitle;
  final Widget body;
  final Widget floatingActionButton;
  final VoidCallback onSearch;
  final PreferredSizeWidget bottom;

  @override
  Widget build(BuildContext context) {
    if (getCurrentBreakpoint(context) == ResponsiveBreakpoints.potrait) {
      return Scaffold(
        appBar: KuzzleAppBar(
          subtitle: subtitle,
          onSearch: onSearch,
          bottom: bottom,
        ),
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: const KuzzleDrawer(),
      );
    } else {
      return Flex(
        direction: Axis.horizontal,
        children: [
          const Material(
            child: Card(
              margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
              borderOnForeground: false,
              elevation: 2,
              child: KuzzleDrawer(),
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: KuzzleAppBar(
                subtitle: subtitle,
                bottom: bottom,
                onSearch: onSearch,
              ),
              body: body,
              floatingActionButton: floatingActionButton,
            ),
          ),
        ],
      );
    }
  }
}
