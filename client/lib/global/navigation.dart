import "package:flutter/material.dart";

class Navigation {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static setNavigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  /// Pushes the given child onto the current [MaterialApp]'s [Navigator].
  static Future push(
    Widget child, {
    /// Function to call after the pushed page is popped.
    void Function(dynamic value)? then,

    /// Whether the page should replace the current page or be pushed on top.
    bool replaceOne = false,
    bool replaceAll = false,
  }) {
    assert(
      _navigatorKey.currentState != null,
      "Navigator key must be initialized.",
    );

    if (replaceAll)
      return _navigatorKey.currentState!
          .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => child),
            (_) => false,
          )
          .then((value) => then?.call(value));
    else if (replaceOne)
      return _navigatorKey.currentState!
          .pushReplacement(MaterialPageRoute(builder: (context) => child))
          .then((value) => then?.call(value));

    return _navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => child))
        .then((value) => then?.call(value));
  }

  static void pop<T extends Object?>([T? result]) =>
      _navigatorKey.currentState!.pop(result);
}