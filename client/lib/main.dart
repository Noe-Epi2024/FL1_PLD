import 'package:flutter/material.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/hypertools.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Navigation.setNavigatorKey(navigatorKey);
  Messenger.setMessengerKey(messengerKey);

  runApp(HyperTools(navigatorKey: navigatorKey, messengerKey: messengerKey));
}
