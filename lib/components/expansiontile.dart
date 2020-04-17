import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';

class BaseExpansionTile<T extends Object> extends StatefulWidget {
  const BaseExpansionTile({
    @required this.title,
    @required this.items,
    @required this.addRoute,
    @required this.manageRoute,
    @required this.buildChild,
    @required this.icon,
    this.onValueChange,
  });

  final String title;
  final List<T> items;
  final Route<void> manageRoute;
  final Route<void> addRoute;
  final Widget Function(T) buildChild;
  final Icon icon;
  final void Function(bool) onValueChange;

  @override
  _BaseExpansionTileState<T> createState() => _BaseExpansionTileState<T>();
}

class _BaseExpansionTileState<T extends Object>
    extends State<BaseExpansionTile<T>> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _borderColor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;
  Animation<Color> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) != null;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openNewBaseModelPage() {
    Navigator.of(context).push<void>(widget.addRoute);
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
      if (widget.onValueChange != null) {
        widget.onValueChange(_isExpanded);
      }
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final borderSideColor = _borderColor.value ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value ?? Colors.transparent,
        border: Border(
          top: BorderSide(color: borderSideColor),
          bottom: BorderSide(color: borderSideColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            textColor: _headerColor.value,
            child: ListTile(
              dense: true,
              onTap: _handleTap,
              leading: widget.icon,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title),
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.expand_more),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _openNewBaseModelPage,
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Column(
                children: widget.items.map<Widget>(widget.buildChild).toList()
                  ..add(
                    ListTile(
                      dense: true,
                      title: Text('Manage ${widget.title}'),
                      onTap: () {
                        Navigator.of(context).push(widget.manageRoute);
                      },
                    ),
                  ),
              ),
            ),
    );
  }
}
