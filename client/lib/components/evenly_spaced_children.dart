import 'package:flutter/material.dart';

class EvenlySpacedChildren extends StatelessWidget {
  const EvenlySpacedChildren({
    required this.children, super.key,
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
    if (axis == Axis.horizontal) {
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children.map((Widget e) => Expanded(child: e)).toList(),
      );
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: children.map((Widget e) => Flexible(child: e)).toList(),
    );
  }
}
