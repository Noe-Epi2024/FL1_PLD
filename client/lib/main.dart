import 'package:flutter/material.dart';

import 'app.dart';
import 'global/messenger.dart';
import 'global/navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Navigation.setNavigatorKey(navigatorKey);
  Messenger.setMessengerKey(messengerKey);

  runApp(
    App(
      navigatorKey: navigatorKey,
      messengerKey: messengerKey,
    ),
  );
}
