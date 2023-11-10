import 'package:flutter/material.dart';

class Messenger {
  static late GlobalKey<ScaffoldMessengerState> _messengerKey;

  static setMessengerKey(GlobalKey<ScaffoldMessengerState> key) =>
      _messengerKey = key;

  static void showSnackBarError(String content) =>
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.error),
              ),
              Text(content, style: const TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );

  static void showSnackBarSuccess(String content) =>
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.error),
              ),
              Text(content, style: const TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
}
