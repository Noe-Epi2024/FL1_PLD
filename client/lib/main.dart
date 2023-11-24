import "package:flutter/material.dart";

import "hypertools.dart";
import "global/messenger.dart";
import "global/navigation.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Navigation.setNavigatorKey(navigatorKey);
  Messenger.setMessengerKey(messengerKey);

  runApp(HyperTools(navigatorKey: navigatorKey, messengerKey: messengerKey));
}
