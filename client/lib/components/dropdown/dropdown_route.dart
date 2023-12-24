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
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext _, BoxConstraints constraints) {
              final double height = min(300, constraints.maxHeight);
              final double width = min(parentSize.width, constraints.maxWidth);

              final double x =
                  min(parentOffset.dx, constraints.maxWidth - width);
              final double y = min(
                parentOffset.dy + parentSize.height / 2,
                constraints.maxHeight - height,
              );

              return Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  InkWell(
                    onTap: Navigator.of(context).pop,
                    overlayColor: const MaterialStatePropertyAll<Color>(
                      Colors.transparent,
                    ),
                  ),
                  Positioned(
                    left: x,
                    top: y,
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: child,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
}
