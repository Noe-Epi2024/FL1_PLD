import "package:flutter/material.dart";

class AdaptativeLayout extends StatelessWidget {
  const AdaptativeLayout({
    super.key,
    this.mobileLayout,
    this.tabletLayout,
    this.desktopLayout,
    this.defaultLayout,
  });

  final Widget? mobileLayout;
  final Widget? tabletLayout;
  final Widget? desktopLayout;
  final Widget? defaultLayout;

  static const _kMobileMaxWidth = 576;
  static const _kTabletMaxWidth = 992;

  @override
  Widget build(BuildContext context) {
    if (desktopLayout != null &&
        MediaQuery.of(context).size.width > _kTabletMaxWidth)
      return desktopLayout!;
    else if (tabletLayout != null &&
        MediaQuery.of(context).size.width > _kMobileMaxWidth)
      return tabletLayout!;
    else if (mobileLayout != null) return mobileLayout!;

    return defaultLayout ??
        const Center(child: Text("No fitting layout provided."));
  }
}
