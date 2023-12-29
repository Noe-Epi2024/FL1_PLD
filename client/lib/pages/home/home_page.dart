import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/fields/search_bar_field.dart';
import 'package:hyper_tools/components/layouts/app/app_layout_desktop.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/requests/projects/get_projects.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/projects/projects_model.dart';
import 'package:hyper_tools/pages/home/components/create_project/create_project_dialog.dart';
import 'package:hyper_tools/pages/home/components/project_preview.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/profile/profile_page.dart';
import 'package:hyper_tools/resources/resources.dart';
import 'package:provider/provider.dart';

part 'components/home_page_content.dart';
part 'components/mobile/home_page_mobile.dart';
part 'components/dekstop/home_page_desktop.dart';
part 'components/home_page_search_bar.dart';
part 'components/projects_list.dart';
part 'components/create_project_button.dart';
part 'components/mobile/home_page_mobile_loader.dart';

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
      final ProjectsModel projects = await GetProjects().send();

      provider.setSuccessState(projects);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_loadProjects(context));
        return null;
      },
      <Object?>[],
    );

    return const AdaptativeLayout(
      desktopLayout: _HomePageDesktop(),
      mobileLayout: _HomePageMobile(),
    );
  }
}
