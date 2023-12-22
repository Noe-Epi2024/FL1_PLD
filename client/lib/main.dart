import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/hypertools.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Navigation.setNavigatorKey(navigatorKey);
  Messenger.setMessengerKey(messengerKey);
  unawaited(initializeDateFormatting('fr_FR'));

  runApp(HyperTools(navigatorKey: navigatorKey, messengerKey: messengerKey));
}
