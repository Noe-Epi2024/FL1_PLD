import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/requests/projects/projects_requests.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project_preview_model.dart';
import 'package:hyper_tools/models/projects_model.dart';
import 'package:hyper_tools/pages/home/components/project_preview.dart';
import 'package:hyper_tools/pages/home/home_page_provider.dart';
import 'package:hyper_tools/pages/home/provider_resolver.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';
import 'package:hyper_tools/resources/resources.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<HomePageProvider>(
        create: (BuildContext _) => HomePageProvider(),
        child: const _HomePageBuilder(),
      );
}

class _HomePageBuilder extends HookWidget {
  const _HomePageBuilder();

  Future<ProjectsModel> _getProjects(BuildContext context) async {
    final HomePageProvider provider = context.read<HomePageProvider>();

    try {
      final ProjectsModel projects = await GetProjects().get();

      provider
        ..projects = projects
        ..isLoading = false;

      return projects;
    } on ErrorModel catch (e) {
      provider
        ..error = e
        ..isLoading = false;

      return Future<ProjectsModel>.error(e);
    }
  }

  void _onSearchChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<HomePageProvider>().filter = controller.text;
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onSearchChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  AppBar _appBar(BuildContext context) => AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await LocalStorage.clear(Consts.accessTokenKey);
              await Navigation.push(const LandingPage(), replaceAll: true);
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
        onPressed: () {},
        child: const Icon(Boxicons.bx_plus),
      );

  Text _welcomeText(BuildContext context) => Text(
        'Bonjour, Henry',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      );

  TextField _searchBar(BuildContext context, TextEditingController controller) {
    final String filter = context.select<HomePageProvider, String>(
      (HomePageProvider provider) => provider.filter,
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

  Widget _builder(BuildContext context, TextEditingController controller) {
    final String filter = context.select<HomePageProvider, String>(
      (HomePageProvider provider) => provider.filter,
    );

    return ListView(
      padding: const EdgeInsets.only(top: 32, bottom: 100, left: 16, right: 16),
      children: <Widget>[
        _welcomeText(context),
        32.ph,
        _searchBar(context, controller),
        8.ph,
        ...context
            .read<HomePageProvider>()
            .projects!
            .projects
            .where(
              (ProjectPreviewModel element) => element.name.contains(filter),
            )
            .map(ProjectPreview.new),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(() => _initializeController(context, controller));

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _floatingActionButton(context),
      body: ProviderResolver<HomePageProvider>.future(
        future: _getProjects,
        builder: (BuildContext builderContext) =>
            _builder(builderContext, controller),
      ),
    );
  }
}
