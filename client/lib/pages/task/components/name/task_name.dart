part of '../../task_page.dart';

class _TaskName extends StatelessWidget {
  const _TaskName();

  @override
  Widget build(BuildContext context) => ProviderResolver<TaskProvider>(
        loader: const ShimmerPlaceholder(height: 16, width: 60),
        builder: (BuildContext context) =>
            ChangeNotifierProvider<TaskNameProvider>(
          create: (_) => TaskNameProvider(
            initialName: context.read<TaskProvider>().task?.name,
          ),
          child: const _TaskNameBuilder(),
        ),
      );
}

class _TaskNameBuilder extends HookWidget {
  const _TaskNameBuilder();

  void _onNameChanged(BuildContext context, String name) {
    context.read<TaskNameProvider>().currentName = name;
  }

  Future<void> _onClickSave(BuildContext context) async {
    final TaskNameProvider provider = context.read<TaskNameProvider>();
    final TaskProvider taskProvider = context.read<TaskProvider>();

    try {
      await PatchTask(
        projectId: taskProvider.projectId,
        taskId: taskProvider.taskId,
        name: provider.currentName,
      ).send();

      taskProvider.setName(provider.currentName);

      if (context.mounted) {
        FocusScope.of(context).unfocus();
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
      }
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  bool _showSaveButton(BuildContext context) {
    final String? currentName = context.select<TaskNameProvider, String?>(
      (TaskNameProvider provider) => provider.currentName,
    );

    final String? projectName = context.watch<TaskProvider>().task?.name;

    return currentName != null &&
        currentName.isNotEmpty &&
        currentName != projectName;
  }

  Widget _buildNameField(TextEditingController controller) => Builder(
        builder: (BuildContext context) => TextField(
          readOnly: !RoleHelper.canEditTask(
            context.read<ProjectProvider>().project!.role,
          ),
          style: Theme.of(context).appBarTheme.titleTextStyle,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          decoration: const InputDecoration(
            filled: false,
            hintText: 'Écrire un nom',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      );

  Widget _buildSaveButton() => Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: () async => _onClickSave(context),
          child: const Text('Enregistrer'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        useTextEditingController(text: context.read<TaskProvider>().task?.name);

    useEffect(
      controller
          .onValueChanged((String value) => _onNameChanged(context, value)),
      <Object?>[],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _buildNameField(controller)),
        if (_showSaveButton(context)) _buildSaveButton(),
      ],
    );
  }
}
