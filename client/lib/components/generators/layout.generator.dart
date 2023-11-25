import "package:flutter/material.dart";

class LayoutGenerator {
  static const _kMobileMaxWidth = 576;
  static const _kTabletMaxWidth = 992;

  /// Returns a widget based on the width of the screen.
  static Widget adaptativeLayout(
    BuildContext context, {
    Widget? mobileLayout,
    Widget? tabletLayout,
    Widget? desktopLayout,
    Widget? defaultLayout,
  }) {
    if (desktopLayout != null &&
        MediaQuery.of(context).size.width > _kTabletMaxWidth)
      return desktopLayout;
    else if (tabletLayout != null &&
        MediaQuery.of(context).size.width > _kMobileMaxWidth)
      return tabletLayout;
    else if (mobileLayout != null) return mobileLayout;

    return defaultLayout ??
        const Center(child: Text("No fitting layout provided."));
  }

  /// Aligns evenly [children] along the given axis.
  static Widget evenlySpacedWidgets({
    required List<Widget> children,
    Axis axis = Axis.horizontal,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
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
