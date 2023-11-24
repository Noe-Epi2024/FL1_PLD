import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "bloc/authentication/authentication.bloc.dart";
import "components/generators/layout.generator.dart";
import "pages/landing/landing.page.dart";
import "theme/theme.dart";

class HyperTools extends StatelessWidget {
  const HyperTools({
    super.key,
    required this.navigatorKey,
    required this.messengerKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> messengerKey;

  List<BlocProvider> get _blocProviders => [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
      ];

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _blocProviders,
        child: MaterialApp(
          title: "HyperTools",
          theme: ThemeGenerator.generate(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: messengerKey,
          home: LayoutGenerator.adaptativeLayout(
            context,
            mobileLayout: const LandingPage(),
          ),
        ),
      );
}
