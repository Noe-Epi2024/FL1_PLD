import 'package:flutter/material.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_page.dart';
import 'package:provider/provider.dart';

class ProjectQuickAccess extends StatelessWidget {
  const ProjectQuickAccess(this.projectPreview, {super.key});

  final ProjectPreviewModel projectPreview;

  Future<void> _onClick(BuildContext context) async {
    await Navigation.push(
      ChangeNotifierProvider<HomeProvider>.value(
        value: context.read<HomeProvider>(),
        child: ProjectPage(projectId: projectPreview.id),
      ),
      replaceOne: true,
    );
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async => _onClick(context),
        child: Container(
          padding: 16.all,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: TitleText(projectPreview.name),
        ),
      );
}
