part of '../../home_page.dart';

class _HomePageMobile extends HookWidget {
  const _HomePageMobile();

  IconButton _buildProfileButton(BuildContext context) => IconButton(
        icon: const FaIcon(FontAwesomeIcons.user),
        onPressed: () async {
          await Navigation.push(
            ChangeNotifierProvider<HomeProvider>.value(
              value: context.read<HomeProvider>(),
              child: const ProfilePage(),
            ),
          );
        },
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        actions: <Widget>[_buildProfileButton(context)],
        leadingWidth: 42,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Resources.logo(color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) => ProviderResolver<HomeProvider>(
        loader: const _HomePageMobileLoader(),
        builder: (BuildContext resolverContext) => Scaffold(
          appBar: _buildAppBar(context),
          floatingActionButton: const _CreateProjectButton(),
          body: const SafeArea(child: _HomePageContent()),
        ),
      );
}
