import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/requests/project/post_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class CreateProjectDialog extends HookWidget {
  const CreateProjectDialog({super.key});

  Future<void> _onClickCreate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final HomeProvider provider = context.read<HomeProvider>();

    try {
      final String id = await PostProject(name: controller.text).post();

      final ProjectPreviewModel projectPreview = ProjectPreviewModel(
        id: id,
        membersCount: 1,
        name: controller.text,
        role: ProjectRole.owner,
      );

      provider.addProject(projectPreview);
    } on ErrorModel catch (e) {
      e.show();
    } finally {
      Navigation.pop();
    }
  }

  Widget _buildDescription() => Builder(
        builder: (BuildContext context) => Text(
          'En créant un projet vous en devenez propriétaire et avez la possibilité de gérer vos collaborateurs.',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      );

  TitleText _buildTitle() => const TitleText('Créer un nouveau projet');

  Widget _buildCreateButton(TextEditingController controller) => Builder(
        builder: (BuildContext context) => ElevatedButton(
          onPressed: () async => _onClickCreate(context, controller),
          child: const Text('Créer'),
        ),
      );

  TextButton _cancelButton() => const TextButton(
        onPressed: Navigation.pop,
        child: Text('Annuler'),
      );

  TextField _nameField(TextEditingController controller) => TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(hintText: 'Nom du projet'),
        controller: controller,
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    return Dialog(
      child: Padding(
        padding: 32.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(),
            16.height,
            _buildDescription(),
            32.height,
            _nameField(controller),
            16.height,
            EvenlySizedChildren(
              children: <Widget>[
                _cancelButton(),
                _buildCreateButton(controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
