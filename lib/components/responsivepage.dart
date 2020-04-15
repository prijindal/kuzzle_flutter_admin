import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import '../helpers/responsive.dart';

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({
    this.subtitle,
    this.body,
    this.floatingActionButton,
  });
  final String subtitle;
  final Widget body;
  final Widget floatingActionButton;

  @override
  _ResponsiveScaffoldState createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  ResponsiveBreakpoints get _breakpoint => getCurrentBreakpoint(context);

  @override
  Widget build(BuildContext context) {
    if (_breakpoint == ResponsiveBreakpoints.potrait) {
      return Scaffold(
        appBar: KuzzleAppBar(
          subtitle: widget.subtitle,
        ),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
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
                subtitle: widget.subtitle,
                preferredSize: const Size.fromHeight(64),
              ),
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
            ),
          ),
        ],
      );
    }
  }
}
