import "package:flutter/material.dart";

class EvenlySpacedChildren extends StatelessWidget {
  const EvenlySpacedChildren({
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.horizontal)
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children.map((e) => Expanded(child: e, flex: 1)).toList(),
      );

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: children.map((e) => Flexible(child: e, flex: 1)).toList(),
    );
  }
}
