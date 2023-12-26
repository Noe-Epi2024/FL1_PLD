import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/requests/projects/get_projects.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/projects/projects_model.dart';
import 'package:hyper_tools/pages/home/components/create_project_modal.dart';
import 'package:hyper_tools/pages/home/components/project_preview.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/profile/profile_page.dart';
import 'package:hyper_tools/resources/resources.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: const _HomePageBuilder(),
      );
}

class _HomePageBuilder extends HookWidget {
  const _HomePageBuilder();

  Future<void> _loadProjects(BuildContext context) async {
    final HomeProvider provider = context.read<HomeProvider>();

    try {
      final ProjectsModel projects = await GetProjects().get();

      provider
        ..projects = projects
        ..isLoading = false;
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  void _onSearchChanged(
    BuildContext context,
    String filter,
  ) {
    context.read<HomeProvider>().filter = filter;
  }

  Future<void> _onClickCreateProject(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<HomeProvider>.value(
        value: context.read<HomeProvider>(),
        builder: (__, ___) => const CreateProjectModal(),
      ),
    );
  }

  List<Widget> _getPreviews(BuildContext context) {
    final HomeProvider provider = context.watch<HomeProvider>();
    final String filter = provider.filter;
    final List<ProjectPreviewModel> projectPreviews =
        provider.projects?.projects ?? <ProjectPreviewModel>[];

    if (projectPreviews.isEmpty) {
      return <Widget>[];
    }

    return projectPreviews
        .where((ProjectPreviewModel preview) => preview.name.contains(filter))
        .map(ProjectPreview.new)
        .toList();
  }

  AppBar _appBar(BuildContext context) => AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigation.push(
                ChangeNotifierProvider<HomeProvider>.value(
                  value: context.read<HomeProvider>(),
                  child: const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Boxicons.bx_user),
          ),
        ],
        leadingWidth: 42,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Resources.logo(color: Colors.black),
        ),
      );

  FloatingActionButton _floatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () async => _onClickCreateProject(context),
        child: const Icon(Boxicons.bx_plus),
      );

  Text _welcomeText(BuildContext context) => Text(
        'Bonjour, ${context.watch<HomeProvider>().projects?.name}',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      );

  TextField _searchBar(BuildContext context, TextEditingController controller) {
    final String filter = context.select<HomeProvider, String>(
      (HomeProvider provider) => provider.filter,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Chercher un projet',
        prefixIcon: const Icon(Boxicons.bx_search),
        suffixIcon: filter.isEmpty
            ? null
            : TextButton(
                onPressed: controller.clear,
                child: Icon(
                  Boxicons.bxs_x_circle,
                  color: Theme.of(context).hintColor,
                ),
              ),
      ),
    );
  }

  Widget _builder(BuildContext context, TextEditingController controller) =>
      ListView(
        padding:
            const EdgeInsets.only(top: 32, bottom: 128, left: 16, right: 16),
        children: <Widget>[
          _welcomeText(context),
          32.height,
          _searchBar(context, controller),
          8.height,
          ..._getPreviews(context),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      controller
          .onValueChanged((String value) => _onSearchChanged(context, value)),
    );

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _floatingActionButton(context),
      body: SafeArea(
        child: ProviderResolver<HomeProvider>.future(
          future: () async => _loadProjects(context),
          builder: (BuildContext builderContext) =>
              _builder(builderContext, controller),
        ),
      ),
    );
  }
}
