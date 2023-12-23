import 'package:flutter/material.dart';

class Messenger {
  static late GlobalKey<ScaffoldMessengerState> _messengerKey;

  static GlobalKey<ScaffoldMessengerState> setMessengerKey(
    GlobalKey<ScaffoldMessengerState> key,
  ) =>
      _messengerKey = key;

  static void showSnackBarError(String content) {
    assert(
      _messengerKey.currentState != null,
      'Navigator key must be initialized.',
    );

    _messengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
            Text(content, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSnackBarSuccess(String content) {
    assert(
      _messengerKey.currentState != null,
      'Navigator key must be initialized.',
    );

    _messengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.check_circle, color: Colors.white),
            ),
            Text(content, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showSnackBarQuickInfo(String content, BuildContext context) {
    assert(
      _messengerKey.currentState != null,
      'Navigator key must be initialized.',
    );

    _messengerKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.check_circle, color: Colors.white),
            ),
            Text(content, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
