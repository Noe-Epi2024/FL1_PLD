import 'package:flutter/material.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/http/requests/project/task/get_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';
import 'package:hyper_tools/pages/task/components/dates/task_end_date.dart';
import 'package:hyper_tools/pages/task/components/dates/task_start_date.dart';
import 'package:hyper_tools/pages/task/components/description/task_description.dart';
import 'package:hyper_tools/pages/task/components/members/members_dropdown.dart';
import 'package:hyper_tools/pages/task/components/subtask/create_subtask_modal.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask.dart';
import 'package:hyper_tools/pages/task/components/task_page_loader.dart';
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

  Future<void> _loadTask(BuildContext context) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      final TaskModel task =
          await GetTask(projectId: projectId, taskId: taskId).get();

      provider
        ..task = task
        ..isLoading = false;
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  Future<void> _onClickCreateSubtask(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<TaskProvider>.value(
        value: context.read<TaskProvider>(),
        builder: (__, ___) => CreateSubtaskModal(
          projectId: projectId,
          taskId: taskId,
        ),
      ),
    );
  }

  List<Widget> _getSubtasks(BuildContext context) {
    final List<SubtaskModel> subtasks =
        context.watch<TaskProvider>().task?.substasks ?? <SubtaskModel>[];

    return subtasks
        .map(
          (SubtaskModel subtask) => Subtask(
            key: Key(subtask.id),
            projectId: projectId,
            taskId: taskId,
            subtaskId: subtask.id,
          ),
        )
        .toList();
  }

  Widget _progressBar(BuildContext context) {
    final List<SubtaskModel> subtasks =
        context.watch<TaskProvider>().task?.substasks ?? <SubtaskModel>[];

    final double progress = subtasks.isEmpty
        ? 0
        : subtasks.where((SubtaskModel subtask) => subtask.isDone).length /
            subtasks.length;

    return Card(
      margin: 16.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
      ),
    );
  }

  Widget _assignedTo(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Assigné à',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ProjectMembersDropdown(
            projectId: projectId,
            taskId: taskId,
          ),
        ],
      );

  Widget _dates(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Dates',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          EvenlySizedChildren(
            children: <Widget>[
              TaskStartDate(projectId: projectId, taskId: taskId),
              TaskEndDate(projectId: projectId, taskId: taskId),
            ],
          ),
        ],
      );

  Widget _subtasks(BuildContext context) => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('À faire'),
        children: <Widget>[
          Column(children: _getSubtasks(context)),
        ],
      );

  Widget _progress(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText(
            'Progression',
            padding: 16.horizontal,
          ),
          16.height,
          _progressBar(context),
        ],
      );

  Widget _informations(BuildContext context) => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('Informations'),
        children: <Widget>[
          Card(
            margin: 16.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TaskDescription(projectId: projectId, taskId: taskId),
                  8.height,
                  _dates(context),
                  8.height,
                  _assignedTo(context),
                ],
              ),
            ),
          ),
        ],
      );

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(
          context.read<TaskProvider>().task!.name,
          style: const TextStyle(color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) => ProviderResolver<TaskProvider>.future(
        future: () async => _loadTask(context),
        loader: const TaskPageLoader(),
        builder: (BuildContext builderContext) => Scaffold(
          appBar: _appBar(builderContext),
          floatingActionButton: FloatingActionButton(
            onPressed: () async => _onClickCreateSubtask(context),
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 100),
              children: <Widget>[
                _progress(builderContext),
                _informations(builderContext),
                _subtasks(builderContext),
              ],
            ),
          ),
        ),
      );
}
