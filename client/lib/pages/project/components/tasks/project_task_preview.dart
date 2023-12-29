import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/extensions/datetime_extension.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/string_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/delete_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_page.dart';
import 'package:hyper_tools/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TaskPreview extends StatelessWidget {
  const TaskPreview({required this.task, super.key});

  final TaskPreviewModel task;

  Future<void> _onTapPreview(BuildContext context) async {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    await Navigation.push(
      MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
          ChangeNotifierProvider<ProjectProvider>.value(value: projectProvider),
        ],
        child: TaskPage(task.id),
      ),
    );
  }

  Future<void> _onClickDelete(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();

    try {
      await DeleteTask(projectId: provider.projectId, taskId: task.id).send();

      provider.deleteTaskPreview(task.id);

      if (context.mounted) Messenger.showSnackBarQuickInfo('Supprimé', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _buildName() => Builder(
        builder: (BuildContext context) => Text(
          task.name.or('Tâche sans nom'),
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildDates() => Builder(
        builder: (BuildContext context) {
          final DateTime? startDate = task.startDate;
          final DateTime? endDate = task.endDate;
          final DateTime today = DateTime.now();
          final bool isOngoing = !(startDate == null && endDate == null) &&
              (startDate?.isBefore(today) ?? true) &&
              (endDate?.isAfter(today) ?? true);

          return Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.calendarDays,
                size: 16,
                color: Theme.of(context).hintColor,
              ),
              8.width,
              Text(
                '${startDate?.toFrench ?? "Indefini"} - ${endDate?.toFrench ?? "Indefini"}',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              16.width,
              if (isOngoing) _buildOngoingTag(),
            ],
          );
        },
      );

  Container _buildOngoingTag() => Container(
        alignment: Alignment.centerRight,
        padding: 4.horizontal,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFFBF00)),
          color: const Color(0xFFFFBF00).withAlpha(50),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'En cours',
          style: TextStyle(color: Color(0xFFFFBF00)),
        ),
      );

  Widget _buildAssignedTo() => Builder(
        builder: (BuildContext context) => Text(
          'Assigné à ${task.ownerName.or("personne")}',
        ),
      );

  Widget _buildProgress() => Builder(
        builder: (BuildContext context) {
          final int? progress =
              context.read<ProjectProvider>().getTaskProgress(task.id);

          if (progress == null) return const Text('Pas encore de sous-tâche');
          return Row(
            children: <Widget>[
              Expanded(
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius:
                      BorderRadius.circular(ThemeGenerator.kBorderRadius),
                  minHeight: 10,
                  value: progress / 100.0,
                ),
              ),
              16.width,
              Text(
                '$progress%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      );

  SlidableAction _buildDeleteButton() => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  @override
  Widget build(BuildContext context) {
    final ProjectRole role = context.read<ProjectProvider>().project!.role;

    return Slidable(
      endActionPane: RoleHelper.canEditTask(role)
          ? ActionPane(
              motion: const ScrollMotion(),
              children: <Widget>[_buildDeleteButton()],
            )
          : null,
      child: Card(
        margin: 4.vertical,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async => _onTapPreview(context),
          child: Padding(
            padding: 16.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildName(),
                4.height,
                _buildDates(),
                4.height,
                _buildAssignedTo(),
                4.height,
                _buildProgress(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
