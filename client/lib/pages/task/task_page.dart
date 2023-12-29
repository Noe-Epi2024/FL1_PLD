import 'package:flutter/material.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/get_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/dates/task_end_date.dart';
import 'package:hyper_tools/pages/task/components/dates/task_start_date.dart';
import 'package:hyper_tools/pages/task/components/description/task_description.dart';
import 'package:hyper_tools/pages/task/components/members/members_dropdown.dart';
import 'package:hyper_tools/pages/task/components/name/task_name.dart';
import 'package:hyper_tools/pages/task/components/subtask/create_subtask_field.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask.dart';
import 'package:hyper_tools/pages/task/components/task_page_loader.dart';
import 'package:hyper_tools/pages/task/components/task_progress_bar.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage(this.taskId, {super.key});

  final String taskId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<TaskProvider>(
        create: (_) => TaskProvider(
          taskId: taskId,
          projectProvider: context.read<ProjectProvider>(),
        ),
        child: const _TaskPageBuilder(),
      );
}

class _TaskPageBuilder extends StatelessWidget {
  const _TaskPageBuilder();

  Future<void> _loadTask(BuildContext context) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      final TaskModel task =
          await GetTask(projectId: provider.projectId, taskId: provider.taskId)
              .send();

      provider.setSuccessState(task);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  Widget _buildSubtasksList() => Builder(
        builder: (BuildContext context) {
          final TaskProvider provider = context.watch<TaskProvider>();
          final List<SubtaskModel> subtasks =
              provider.task?.substasks ?? <SubtaskModel>[];

          return Column(
            children: subtasks
                .map(
                  (SubtaskModel subtask) =>
                      Subtask(subtask, key: Key(subtask.id)),
                )
                .toList(),
          );
        },
      );

  Widget _buildProgressBar() => Card(
        margin: 16.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (BuildContext context) {
              final int? progress =
                  context.watch<TaskProvider>().progressPercent;

              return progress == null
                  ? const Row(
                      children: <Widget>[
                        Expanded(child: Text('Aucune sous-tâche')),
                      ],
                    )
                  : const TaskProgressBar();
            },
          ),
        ),
      );

  Widget _buildAssignedTo() => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Assigné à',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ProjectMembersDropdown(),
        ],
      );

  Widget _buildRemainingTime() => Builder(
        builder: (BuildContext context) {
          final TaskProvider provider = context.watch<TaskProvider>();
          final DateTime? startDate = provider.task!.startDate;
          final DateTime? endDate = provider.task!.endDate;

          if (startDate == null || endDate == null) {
            return const SizedBox.shrink();
          }

          return Text(
            'Durée estimée : ${endDate.difference(startDate).inDays} jours',
          );
        },
      );

  Widget _buildDates() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Dates',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const EvenlySizedChildren(
            children: <Widget>[TaskStartDate(), TaskEndDate()],
          ),
          _buildRemainingTime(),
        ],
      );

  Widget _buildSubtasks() => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('À faire'),
        children: <Widget>[
          Builder(
            builder: (BuildContext context) => Column(
              children: <Widget>[
                _buildSubtasksList(),
                if (RoleHelper.canEditTask(
                  context.read<ProjectProvider>().project!.role,
                ))
                  const CreateSubtaskField(),
              ],
            ),
          ),
        ],
      );

  Widget _buildProgress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText('Progression', padding: 16.horizontal),
          16.height,
          _buildProgressBar(),
        ],
      );

  Widget _buildInformations() => ExpansionTile(
        initiallyExpanded: true,
        title: const TitleText('Informations'),
        children: <Widget>[
          Card(
            margin: 16.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  const TaskDescription(),
                  8.height,
                  _buildDates(),
                  8.height,
                  _buildAssignedTo(),
                ],
              ),
            ),
          ),
        ],
      );

  AppBar _appBar() => AppBar(title: const TaskName());

  Widget _builder(BuildContext builderContext) => Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(top: 16, bottom: 128),
            children: <Widget>[
              _buildProgress(),
              _buildInformations(),
              _buildSubtasks(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ProviderResolver<TaskProvider>.future(
        future: () async => _loadTask(context),
        loader: const TaskPageLoader(),
        builder: _builder,
      );
}
