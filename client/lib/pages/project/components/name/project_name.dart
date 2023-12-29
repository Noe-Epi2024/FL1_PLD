part of '../../project_page.dart';

class _ProjectName extends StatelessWidget {
  const _ProjectName();

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProjectNameProvider>(
        create: (_) => ProjectNameProvider(
          initialName: context.read<ProjectProvider>().project!.name,
        ),
        child: const _ProjectNameBuilder(),
      );
}

class _ProjectNameBuilder extends HookWidget {
  const _ProjectNameBuilder();

  void _onNameChanged(BuildContext context, String name) {
    context.read<ProjectNameProvider>().currentName = name;
  }

  Future<void> _onClickSave(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();
    final String name = context.read<ProjectNameProvider>().currentName;

    try {
      await PatchProject(
        projectId: provider.projectId,
        name: name,
      ).send();

      provider.setName(name);

      if (context.mounted) {
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
        FocusScope.of(context).unfocus();
      }
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.read<ProjectProvider>().project?.name,
    );

    useEffect(
      controller
          .onValueChanged((String value) => _onNameChanged(context, value)),
      <Object?>[],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: TextField(
            readOnly: !RoleHelper.canEditProject(
              context.read<ProjectProvider>().project!.role,
            ),
            style: Theme.of(context).appBarTheme.titleTextStyle,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Écrire un nom',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        if (context.select<ProjectNameProvider, String?>(
              (ProjectNameProvider provider) => provider.currentName,
            ) !=
            context.watch<ProjectProvider>().project?.name)
          TextButton(
            onPressed: () async => _onClickSave(context),
            child: const Text('Enregistrer'),
          ),
      ],
    );
  }
}
