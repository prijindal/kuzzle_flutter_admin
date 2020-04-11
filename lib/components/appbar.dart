import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';

class KuzzleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Environment environment;
  final String subtitle;

  KuzzleAppBar({
    @required this.environment,
    this.subtitle,
  });

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              environment.name,
            ),
            if (subtitle != null)
              Visibility(
                visible: true,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
          ],
        ),
      );
}
