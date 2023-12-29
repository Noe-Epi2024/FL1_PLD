import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
import 'package:hyper_tools/pages/profile/components/profile_email.dart';
import 'package:hyper_tools/pages/profile/components/profile_name.dart';
import 'package:hyper_tools/pages/profile/picture/profile_picture.dart';
import 'package:hyper_tools/pages/profile/profile_provider.dart';
import 'package:provider/provider.dart';

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

  Future<void> _onPressLogout() async {
    await LocalStorageHelper.clear(Consts.accessTokenKey);
    await Navigation.push(const LandingPage(), replaceAll: true);
  }

  Align _buildLogoutButton() => Align(
        child: TextButton(
          style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
          ),
          onPressed: _onPressLogout,
          child: const Text('Se déconnecter'),
        ),
      );

  Center _buildProfilePicture() => const Center(
        child: SizedBox(
          height: 96,
          width: 96,
          child: ClipOval(child: ProfilePicture()),
        ),
      );

  Widget _builder(BuildContext context) => ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 128),
        children: <Widget>[
          _buildProfilePicture(),
          const TitleText('Nom'),
          8.height,
          const ProfileName(),
          16.height,
          const TitleText('Email'),
          8.height,
          const ProfileEmail(),
          64.height,
          _buildLogoutButton(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_loadMe(context));
        return null;
      },
      <Object?>[],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ProviderResolver<ProfileProvider>(
        builder: _builder,
      ),
    );
  }
}
