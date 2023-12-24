import 'package:flutter/material.dart';
import 'package:hyper_tools/components/date_picker/date_picker.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/task/get_task.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
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

  Future<bool> _onSelectedStartDate(BuildContext context, DateTime date) async {
    try {
      await PatchTask(projectId: projectId, taskId: taskId, startDate: date)
          .patch();

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);

      return true;
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);

      return false;
    }
  }

  Future<bool> _onSelectedEndDate(BuildContext context, DateTime date) async {
    try {
      await PatchTask(projectId: projectId, taskId: taskId, endDate: date)
          .patch();

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);

      return true;
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);

      return false;
    }
  }

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

  Widget _dates(BuildContext context) {
    final TaskProvider provider = context.read<TaskProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Dates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        EvenlySizedChildren(
          children: <Widget>[
            DatePicker(
              label: 'Début',
              initialDate: provider.task!.startDate,
              onSelected: (DateTime date) async =>
                  _onSelectedStartDate(context, date),
            ),
            DatePicker(
              label: 'Fin',
              initialDate: provider.task!.endDate,
              onSelected: (DateTime date) async =>
                  _onSelectedEndDate(context, date),
            ),
          ],
        ),
      ],
    );
  }

  Widget _subtasks(BuildContext context) => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('À faire'),
        children: <Widget>[
          DecoratedBox(
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
          ),
        ],
      );

  Widget _progress(BuildContext builderContext) => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('Progression'),
        children: <Widget>[
          _progressBar(builderContext),
        ],
      );

  Widget _informations(BuildContext builderContext) => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('Informations'),
        children: <Widget>[
          Card(
            margin: 16.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  _dates(builderContext),
                  8.height,
                  _assignedTo(builderContext),
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
        future: () async => _getTask(context),
        loader: Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        ),
        builder: (BuildContext builderContext) => Scaffold(
          appBar: _appBar(builderContext),
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
