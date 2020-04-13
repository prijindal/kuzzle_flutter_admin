import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/components/drawer.dart';
import '../helpers/responsive.dart';

class ResponsiveScaffold extends StatefulWidget {
  ResponsiveScaffold({
    this.subtitle,
    this.body,
    this.floatingActionButton,
  });
  final String subtitle;
  final Widget body;
  final Widget floatingActionButton;

  _ResponsiveScaffoldState createState() => _ResponsiveScaffoldState();
}

// Size.fromHeight(getCurrentBreakpoint(context) == ResponsiveBreakpoints.landscape ? 64.0 : kToolbarHeight)

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
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
              borderOnForeground: false,
              elevation: 2.0,
              child: KuzzleDrawer(),
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: KuzzleAppBar(
                subtitle: widget.subtitle,
                preferredSize: Size.fromHeight(64.0),
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
