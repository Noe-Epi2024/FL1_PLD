import 'package:flutter/material.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/requests/user/get_me.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/user/me_model.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';
import 'package:hyper_tools/pages/profile/picture/profile_picture.dart';
import 'package:hyper_tools/pages/profile/profile_provider.dart';
import 'package:hyper_tools/pages/profile/components/profile_email.dart';
import 'package:hyper_tools/pages/profile/components/profile_name.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _loadMe(BuildContext context) async {
    final ProfileProvider provider = context.read<ProfileProvider>();

    try {
      final MeModel me = await GetMe().get();

      provider.setSuccessState(me);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  Future<void> _onPressLogout() async {
    await LocalStorage.clear(Consts.accessTokenKey);
    await Navigation.push(const LandingPage(), replaceAll: true);
  }

  Widget _builder(BuildContext context) => ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 128),
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 96,
              width: 96,
              child: ClipOval(child: ProfilePicture()),
            ),
          ),
          const TitleText('Nom'),
          8.height,
          const ProfileName(),
          16.height,
          const TitleText('Email'),
          8.height,
          const ProfileEmail(),
          64.height,
          Align(
            child: TextButton(
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: _onPressLogout,
              child: const Text('Se déconnecter'),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
          builder: (BuildContext providerContext, _) =>
              ProviderResolver<ProfileProvider>.future(
            future: () async => _loadMe(providerContext),
            builder: _builder,
          ),
        ),
      );
}
