part of '../task_page.dart';

class _TaskPageContent extends StatelessWidget {
  const _TaskPageContent();

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

  Widget _buildProgress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText('Progression', padding: 16.horizontal),
          16.height,
          _buildProgressBar(),
        ],
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

  @override
  Widget build(BuildContext context) => ProviderResolver<TaskProvider>(
        builder: (BuildContext context) => ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 128),
          children: <Widget>[
            _buildProgress(),
            _buildInformations(),
            _buildSubtasks(),
          ],
        ),
      );
}
