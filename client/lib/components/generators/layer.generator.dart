import "dart:ui";

import "package:flutter/material.dart";

class LayerGenerator {
  /// Blurs and darken everything behind this widget on the Z axis.
  static Widget get blur => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(color: Colors.black.withAlpha(128)),
      );
}
