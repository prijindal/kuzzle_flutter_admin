import 'package:flutter/material.dart';

class KuzzleDrawer extends StatefulWidget {
  _KuzzleDrawerState createState() => _KuzzleDrawerState();
}

class _KuzzleDrawerState extends State<KuzzleDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            Container(
              height: 64.0,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
          ],
        ),
      );
}
