import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/project/project_page.dart';
import 'package:hyper_tools/theme/theme.dart';

class ProjectPreview extends StatelessWidget {
  const ProjectPreview(this.projectPreviewModel, {super.key});

  final ProjectPreviewModel projectPreviewModel;

  Future<void> _onTapPreview(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<ProjectPage>(
        builder: (BuildContext context) => ProjectPage(projectPreviewModel.id),
      ),
    );
  }

  Widget _roleIcon(BuildContext context) => switch (projectPreviewModel.role) {
        ProjectRole.owner => Icon(
            Boxicons.bx_crown,
            size: 16,
            color: Theme.of(context).hintColor,
          ),
        ProjectRole.writer => Icon(
            Boxicons.bx_edit,
            size: 16,
            color: Theme.of(context).hintColor,
          ),
        ProjectRole.reader => Icon(
            Icons.remove_red_eye_outlined,
            size: 16,
            color: Theme.of(context).hintColor,
          )
      };

  Widget _picture(BuildContext context) => Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            projectPreviewModel.name[0],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _members(BuildContext context) => Text(
        '${projectPreviewModel.membersCount} membre${projectPreviewModel.membersCount > 1 ? "s" : ""}',
        style: TextStyle(color: Theme.of(context).hintColor),
      );

  Widget _name() => Text(
        projectPreviewModel.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _progressBar(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(ThemeGenerator.kBorderRadius),
              minHeight: 10,
              value: projectPreviewModel.progress!.toDouble() / 100,
            ),
          ),
          16.width,
          Text(
            '${projectPreviewModel.progress}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _noTaskYet() => const Text('Pas encore de tâche');

  @override
  Widget build(BuildContext context) => Card(
        margin: 4.vertical,
        child: InkWell(
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
                      _picture(context),
                      16.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _name(),
                            _members(context),
                            8.height,
                            if (projectPreviewModel.progress != null)
                              _progressBar(context)
                            else
                              _noTaskYet(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                16.width,
                _roleIcon(context),
              ],
            ),
          ),
        ),
      );
}
