import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import '../helpers/responsive.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    this.subtitle,
    this.body,
    this.floatingActionButton,
  });
  final String subtitle;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    if (getCurrentBreakpoint(context) == ResponsiveBreakpoints.potrait) {
      return Scaffold(
        appBar: KuzzleAppBar(
          subtitle: subtitle,
        ),
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: KuzzleDrawer(),
      );
    } else {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Material(
            child: Card(
              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              borderOnForeground: false,
              elevation: 2,
              child: KuzzleDrawer(),
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: KuzzleAppBar(
                subtitle: subtitle,
                preferredSize: const Size.fromHeight(64),
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
