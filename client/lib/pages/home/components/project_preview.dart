import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_page.dart';
import 'package:hyper_tools/theme/theme.dart';
import 'package:provider/provider.dart';

class ProjectPreview extends StatelessWidget {
  const ProjectPreview(this.projectPreview, {super.key});

  final ProjectPreviewModel projectPreview;

  Future<void> _onTapPreview(BuildContext context) async {
    await Navigation.push(
      ChangeNotifierProvider<HomeProvider>.value(
        value: context.read<HomeProvider>(),
        child: ProjectPage(projectId: projectPreview.id),
      ),
    );
  }

  Widget _buildRoleIcon(BuildContext context) => FaIcon(
        projectPreview.role.icon,
        size: 14,
        color: Theme.of(context).hintColor,
      );

  Widget _buildPicture(BuildContext context) => Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            projectPreview.name[0],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _buildMembers(BuildContext context) => Text(
        '${projectPreview.membersCount} membre${projectPreview.membersCount > 1 ? "s" : ""}',
        style: TextStyle(color: Theme.of(context).hintColor),
      );

  Widget _buildName() => Text(
        projectPreview.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildProgressBar(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(ThemeGenerator.kBorderRadius),
              minHeight: 10,
              value: projectPreview.progress! / 100,
            ),
          ),
          16.width,
          Text(
            '${projectPreview.progress}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _buildNoTaskYet() => const Text('Pas encore de tâche');

  @override
  Widget build(BuildContext context) => Card(
        margin: 4.vertical,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async => _onTapPreview(context),
          child: Padding(
            padding: 16.all,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildPicture(context),
                      16.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildName(),
                            _buildMembers(context),
                            8.height,
                            if (projectPreview.progress != null)
                              _buildProgressBar(context)
                            else
                              _buildNoTaskYet(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                16.width,
                _buildRoleIcon(context),
              ],
            ),
          ),
        ),
      );
}
