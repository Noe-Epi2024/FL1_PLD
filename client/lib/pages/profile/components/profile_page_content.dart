part of '../profile_page.dart';

class _ProfilePageContent extends StatelessWidget {
  const _ProfilePageContent();

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

  @override
  Widget build(BuildContext context) => ProviderResolver<ProfileProvider>(
        builder: (BuildContext context) => ListView(
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
        ),
      );
}
