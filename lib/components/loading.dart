import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation();

  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}
