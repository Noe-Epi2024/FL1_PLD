import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/models/project_preview_model.dart';
import 'package:hyper_tools/models/project_role.dart';
import 'package:hyper_tools/theme/theme.dart';

class ProjectPreview extends StatelessWidget {
  const ProjectPreview(this.projectPreviewModel, {super.key});

  final ProjectPreviewModel projectPreviewModel;

  Widget _roleIcon(BuildContext context) => switch (projectPreviewModel.role) {
        ProjectRole.owner => Icon(
            Boxicons.bx_crown,
            size: 20,
            color: Theme.of(context).hintColor,
          ),
        ProjectRole.writer => Icon(
            Boxicons.bx_edit,
            size: 20,
            color: Theme.of(context).hintColor,
          ),
        ProjectRole.reader => Icon(
            Icons.remove_red_eye_outlined,
            size: 20,
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
          16.pw,
          Text(
            '${projectPreviewModel.progress}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _noTaskYet() => const Text('Pas encore de tâche');

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: 16.a,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _picture(context),
                    16.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _name(),
                          _members(context),
                          8.ph,
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
              16.pw,
              _roleIcon(context),
            ],
          ),
        ),
      );
}
