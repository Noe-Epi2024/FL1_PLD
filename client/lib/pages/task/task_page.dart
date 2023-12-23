import 'package:flutter/material.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/http/requests/project/task/get_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';
import 'package:hyper_tools/pages/task/components/members_dropdown.dart';
import 'package:hyper_tools/pages/task/components/subtask.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:hyper_tools/theme/theme.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage(this.projectId, this.taskId, {super.key});

  final String projectId;
  final String taskId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<TaskProvider>(
        create: (_) => TaskProvider(),
        child: _TaskPageBuilder(projectId, taskId),
      );
}

class _TaskPageBuilder extends StatelessWidget {
  const _TaskPageBuilder(this.projectId, this.taskId);

  final String projectId;
  final String taskId;

  Future<void> _getTask(BuildContext context) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      final TaskModel task =
          await GetTask(projectId: projectId, taskId: taskId).get();

      provider
        ..task = task
        ..isLoading = false;
    } on ErrorModel catch (e) {
      provider
        ..error = e
        ..isLoading = false;
    }
  }

  // Widget _name() => Text(
  //       taskPreviewModel.name,
  //       style: const TextStyle(fontWeight: FontWeight.bold),
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //     );

  // Widget _dates(BuildContext context) => Row(
  //       children: <Widget>[
  //         Icon(
  //           Boxicons.bx_calendar,
  //           size: 16,
  //           color: Theme.of(context).hintColor,
  //         ),
  //         8.width,
  //         Text(
  //           '${DateHelper.formatDateToFrench(taskPreviewModel.startDate)} - ${DateHelper.formatDateToFrench(taskPreviewModel.endDate)}',
  //           style: TextStyle(color: Theme.of(context).hintColor),
  //         ),
  //       ],
  //     );

  // Text _assignedTo() => Text('Assigné à ${taskPreviewModel.ownerName}');

  Widget _progressBar(BuildContext context) {
    final List<SubtaskModel> subtasks =
        context.select<TaskProvider, List<SubtaskModel>>(
      (TaskProvider provider) => provider.task!.substasks,
    );

    final double progress =
        subtasks.where((SubtaskModel subtask) => subtask.isDone).length /
            subtasks.length;

    return Card(
      margin: 16.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Progression',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            8.height,
            Row(
              children: <Widget>[
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius:
                        BorderRadius.circular(ThemeGenerator.kBorderRadius),
                    minHeight: 15,
                    value: progress,
                  ),
                ),
                16.width,
                Text(
                  '${(progress * 100).ceil()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _assignedTo(BuildContext context) => Card(
        margin: 16.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              const Text(
                'Assigné à',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ProjectMembersDropdown(
                  projectId: projectId,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _dates(BuildContext context) => Card(
        margin: 16.horizontal,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Dates', style: TextStyle(fontWeight: FontWeight.bold)),
              EvenlySizedChildren(
                children: <Widget>[
                  TextField(decoration: InputDecoration(labelText: 'Début')),
                  TextField(decoration: InputDecoration(labelText: 'Fin')),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _subtasks(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: Column(
          children: context
              .select<TaskProvider, List<SubtaskModel>>(
                (TaskProvider provider) => provider.task!.substasks,
              )
              .map(Subtask.new)
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) => ProviderResolver<TaskProvider>.future(
        future: () async => _getTask(context),
        loader: Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        ),
        builder: (BuildContext builderContext) => Scaffold(
          appBar: _appBar(builderContext),
          body: ListView(
            padding: const EdgeInsets.only(top: 32, bottom: 100),
            children: <Widget>[
              _assignedTo(builderContext),
              8.height,
              _dates(builderContext),
              8.height,
              _progressBar(builderContext),
              16.height,
              Padding(
                padding: 16.horizontal,
                child: const Text(
                  'Sous-tâches',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              8.height,
              _subtasks(builderContext),
            ],
          ),
        ),
      );

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(
          context.read<TaskProvider>().task!.name,
          style: const TextStyle(color: Colors.black),
        ),
      );
}
