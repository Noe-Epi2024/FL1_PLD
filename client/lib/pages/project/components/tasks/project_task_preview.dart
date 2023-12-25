import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_page.dart';
import 'package:hyper_tools/theme/theme.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class TaskPreview extends StatelessWidget {
  const TaskPreview({required this.projectId, required this.taskId, super.key});

  final String projectId;
  final String taskId;

  Future<void> _onTapPreview(BuildContext context) async {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    await Navigation.push(
      MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
          ChangeNotifierProvider<ProjectProvider>.value(value: projectProvider),
        ],
        child: TaskPage(projectProvider.project!.id, taskId),
      ),
    );
  }

  Future<void> _onClickDelete(BuildContext context) async {
    try {
      await DeleteTask(projectId: projectId, taskId: taskId).delete();

      Messenger.showSnackBarQuickInfo('Supprimé', context);

      context.read<ProjectProvider>().deleteTaskPreview(taskId);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _name(BuildContext context) => Text(
        context
                .watch<ProjectProvider>()
                .findTaskPreview(taskId)
                ?.name
                .or('Tâche sans nom') ??
            'Tâche sans nom',
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _dates(BuildContext context) {
    final ProjectProvider provider = context.watch<ProjectProvider>();

    final DateTime? startDate = provider.findTaskPreview(taskId)?.startDate;
    final DateTime? endDate = provider.findTaskPreview(taskId)?.endDate;
    final DateTime today = DateTime.now();
    final bool isOngoing = !(startDate == null && endDate == null) &&
        (startDate?.isBefore(today) ?? true) &&
        (endDate?.isAfter(today) ?? true);

    return Row(
      children: <Widget>[
        Icon(
          Boxicons.bx_calendar,
          size: 16,
          color: Theme.of(context).hintColor,
        ),
        8.width,
        Text(
          '${startDate?.toFrench ?? "Indefini"} - ${endDate?.toFrench ?? "Indefini"}',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        16.width,
        if (isOngoing)
          Container(
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
          ),
      ],
    );
  }

  Text _assignedTo(BuildContext context) => Text(
        'Assigné à ${context.watch<ProjectProvider>().findTaskPreview(taskId)?.ownerName ?? "personne"}',
      );

  Widget _progress(BuildContext context) {
    final int? progress =
        context.watch<ProjectProvider>().findTaskPreview(taskId)?.progress;

    if (progress == null) return _noSubtaskYet();

    return Row(
      children: <Widget>[
        Expanded(
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.background,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(ThemeGenerator.kBorderRadius),
            minHeight: 10,
            value: progress.toDouble() / 100.0,
          ),
        ),
        16.width,
        Text(
          '$progress%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  SlidableAction _deleteButton(BuildContext context) => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  Widget _noSubtaskYet() => const Text('Pas encore de sous-tâche');

  @override
  Widget build(BuildContext context) {
    final ProjectRole role = context.read<ProjectProvider>().project!.role;

    return Slidable(
      endActionPane: RoleHelper.canEditTask(role)
          ? ActionPane(
              motion: const ScrollMotion(),
              children: <Widget>[_deleteButton(context)],
            )
          : null,
      child: Card(
        margin: 4.vertical,
        child: InkWell(
          onTap: () async => _onTapPreview(context),
          child: Padding(
            padding: 16.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _name(context),
                _dates(context),
                _assignedTo(context),
                8.height,
                _progress(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
