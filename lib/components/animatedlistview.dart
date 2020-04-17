import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    @required this.itemCount,
    @required this.itemBuilder,
    this.shrinkWrap = false,
  });

  final bool shrinkWrap;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) => AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: shrinkWrap,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
            position: i,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50,
              child: itemBuilder(context, i),
            ),
          ),
        ),
      );
}

class AnimatedColumn extends StatelessWidget {
  const AnimatedColumn({
    this.children = const <Widget>[],
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) => AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
}
