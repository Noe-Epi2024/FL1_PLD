import 'package:flutter/material.dart';
import 'package:hyper_tools/pages/dispatcher/dispatcher_page.dart';
import 'package:hyper_tools/theme/theme.dart';

class HyperTools extends StatelessWidget {
  const HyperTools({
    required this.navigatorKey,
    required this.messengerKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> messengerKey;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'HyperTools',
        theme: ThemeGenerator.generate(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        home: const DispatcherPage(),
      );
}
