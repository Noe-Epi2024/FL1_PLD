import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/layouts/app/components.dart/project_quick_access.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/shimmer_placeholder.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/profile/profile_page.dart';
import 'package:hyper_tools/resources/resources.dart';
import 'package:provider/provider.dart';

class AppLayoutDesktop extends StatelessWidget {
  const AppLayoutDesktop({super.key, this.child});

  final Widget? child;

  Widget _sidebarBuilder(BuildContext context) => ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, bottom: 32),
            child: Text(
              'Mes projets',
              style: TextStyle(color: Theme.of(context).hintColor),
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(height: 0),
          ...context
              .watch<HomeProvider>()
              .projects!
              .projects
              .map(ProjectQuickAccess.new),
        ],
      );

  ListView _sidebarLoader() => ListView.builder(
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          margin: 16.vertical,
          padding: 16.horizontal,
          child: const ShimmerPlaceholder(
            width: 30,
            height: 20,
          ),
        ),
      );

  Widget _buildSidebar() => Builder(
        builder: (BuildContext context) => Container(
          width: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              right: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: ProviderResolver<HomeProvider>(
            loader: _sidebarLoader(),
            builder: _sidebarBuilder,
          ),
        ),
      );

  Padding _buildProfileButton() => Padding(
        padding: 32.horizontal,
        child: Builder(
          builder: (BuildContext context) => TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll<Color>(
                Theme.of(context).colorScheme.onBackground,
              ),
            ),
            child: Row(
              children: <Widget>[
                ProviderResolver<HomeProvider>(
                  builder: (BuildContext context) => Text(
                    context.read<HomeProvider>().projects?.name ?? '',
                  ),
                ),
                16.width,
                const FaIcon(FontAwesomeIcons.user),
              ],
            ),
            onPressed: () async {
              await Navigation.push(
                ChangeNotifierProvider<HomeProvider>.value(
                  value: context.read<HomeProvider>(),
                  child: const ProfilePage(),
                ),
              );
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leadingWidth: 64,
          leading: Padding(
            padding: 8.vertical,
            child: Resources.logo(color: Colors.black),
          ),
          actions: <Widget>[_buildProfileButton()],
        ),
        body: Row(
          children: <Widget>[
            _buildSidebar(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
}
