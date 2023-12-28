import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/patch_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/project/components/name/project_name_provider.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectName extends StatelessWidget {
  const ProjectName({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProjectNameProvider>(
        create: (_) => ProjectNameProvider(
          initialName: context.read<ProjectProvider>().project!.name,
        ),
        child: _ProjectNameBuilder(
          projectId: projectId,
        ),
      );
}

class _ProjectNameBuilder extends HookWidget {
  const _ProjectNameBuilder({
    required this.projectId,
  });

  final String projectId;

  void _onNameChanged(BuildContext context, String name) {
    context.read<ProjectNameProvider>().currentName = name;
  }

  Future<void> _onClickSave(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();
    final String name = context.read<ProjectNameProvider>().currentName;

    try {
      await PatchProject(
        projectId: projectId,
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
