part of 'dropdown.dart';

class _DropdownRoute<T> extends PopupRoute<T> {
  _DropdownRoute({
    required this.child,
    required this.parentSize,
    required this.parentOffset,
    super.settings,
    super.filter,
    super.traversalEdgeBehavior,
  });

  final Size parentSize;
  final Offset parentOffset;
  final Widget child;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dropdown barrier';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            InkWell(onTap: Navigator.of(context).pop),
            Positioned(
              top: parentOffset.dy + parentSize.height + 8,
              left: parentOffset.dx,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: parentSize.width,
                  minWidth: parentSize.width,
                  maxHeight: 300,
                ),
                child: child,
              ),
            ),
          ],
        ),
      );

  @override
  Duration get transitionDuration => Duration.zero;
}
