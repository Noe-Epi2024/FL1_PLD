import "package:flutter/material.dart";
import "pages/landing/landing_page.dart";
import "theme/theme.dart";

class HyperTools extends StatelessWidget {
  const HyperTools({
    super.key,
    required this.navigatorKey,
    required this.messengerKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> messengerKey;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "HyperTools",
        theme: ThemeGenerator.generate(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        home: const LandingPage(),
      );
}
