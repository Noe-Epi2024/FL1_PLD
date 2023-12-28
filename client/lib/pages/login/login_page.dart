import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/fields/password_field.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_desktop.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_mobile.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/texts/headline_text.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/local_storage_helper.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/authentication/post_login.dart';
import 'package:hyper_tools/models/authentication/authentication_model.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/home/home_page.dart';
import 'package:hyper_tools/pages/login/login_provider.dart';
import 'package:hyper_tools/pages/register/register_page.dart';
import 'package:provider/provider.dart';

part 'login_page_mobile.dart';
part 'login_page_desktop.dart';
part 'components/login_page_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        child: AdaptativeLayout(
          mobileLayout: _LoginPageMobile(),
          desktopLayout: _LoginPageDesktop(),
        ),
      );
}
