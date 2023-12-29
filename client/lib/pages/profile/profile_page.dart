import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/layouts/app/app_layout_desktop.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/local_storage_helper.dart';
import 'package:hyper_tools/http/requests/user/get_me.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/user/me_model.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';
import 'package:hyper_tools/pages/profile/components/picture/profile_picture.dart';
import 'package:hyper_tools/pages/profile/components/profile_email.dart';
import 'package:hyper_tools/pages/profile/components/profile_name.dart';
import 'package:hyper_tools/pages/profile/profile_provider.dart';
import 'package:provider/provider.dart';

part 'components/profile_page_content.dart';
part 'components/desktop/profile_page_desktop.dart';
part 'components/mobile/profile_page_mobile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(context),
        child: const _ProfilePageBuilder(),
      );
}

class _ProfilePageBuilder extends HookWidget {
  const _ProfilePageBuilder();

  Future<void> _loadMe(BuildContext context) async {
    final ProfileProvider provider = context.read<ProfileProvider>();

    try {
      final MeModel me = await GetMe().send();

      provider.setSuccessState(me);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_loadMe(context));
        return null;
      },
      <Object?>[],
    );

    return const AdaptativeLayout(
      mobileLayout: _ProfilePageMobile(),
      desktopLayout: _ProfilePageDesktop(),
    );
  }
}
