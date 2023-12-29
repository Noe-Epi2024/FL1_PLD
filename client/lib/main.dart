import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hyper_tools/firebase_options.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/hypertools.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDateFormatting('fr_FR');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final GlobalKey<NavigatorState> navigatorKey =
          GlobalKey<NavigatorState>();
      final GlobalKey<ScaffoldMessengerState> messengerKey =
          GlobalKey<ScaffoldMessengerState>();

      Navigation.setNavigatorKey(navigatorKey);
      Messenger.setMessengerKey(messengerKey);

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(
        HyperTools(navigatorKey: navigatorKey, messengerKey: messengerKey),
      );
    },
    (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}
