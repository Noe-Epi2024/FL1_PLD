import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_desktop.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_mobile.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/pages/login/login_page.dart';
import 'package:hyper_tools/pages/register/register_page.dart';

part 'landing_page_desktop.dart';
part 'landing_page_mobile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) => const AdaptativeLayout(
        mobileLayout: _LandingPageMobile(),
        desktopLayout: _LandingPageDesktop(),
      );
}
