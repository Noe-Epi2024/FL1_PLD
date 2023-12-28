import 'package:flutter/material.dart';

class Navigation {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static GlobalKey<NavigatorState> setNavigatorKey(
    GlobalKey<NavigatorState> key,
  ) =>
      _navigatorKey = key;

  /// Pushes the given child onto the current [MaterialApp]'s [Navigator].
  static Future<T?> push<T extends Object>(
    Widget child, {
    /// Whether the page should replace the current page or be pushed on top.
    bool replaceOne = false,
    bool replaceAll = false,
  }) {
    assert(
      _navigatorKey.currentState != null,
      'Navigator key must be initialized.',
    );

    if (replaceAll) {
      return _navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute<T>(builder: (_) => child),
        (_) => false,
      );
    }

    if (replaceOne) {
      return _navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute<T>(builder: (_) => child),
      );
    }

    return _navigatorKey.currentState!
        .push(MaterialPageRoute<T>(builder: (_) => child));
  }

  static void pop<T extends Object?>([T? result]) =>
      _navigatorKey.currentState!.pop(result);
}
