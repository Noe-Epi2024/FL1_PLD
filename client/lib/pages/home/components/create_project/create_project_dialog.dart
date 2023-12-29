import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';
import 'package:hyper_tools/http/requests/project/post_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/home/components/create_project/create_project_provider.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class CreateProjectDialog extends StatelessWidget {
  const CreateProjectDialog({super.key});

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<CreateProjectProvider>(
        child: const _CreateProjectDialogBuilder(),
        create: (_) => CreateProjectProvider(),
      );
}

class _CreateProjectDialogBuilder extends HookWidget {
  const _CreateProjectDialogBuilder();

  Future<void> _onClickCreate(BuildContext context) async {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final CreateProjectProvider provider =
        context.read<CreateProjectProvider>();

    if (!provider.formKey.currentState!.validate()) return;

    try {
      final String id = await PostProject(name: provider.name).send();

      final ProjectPreviewModel projectPreview = ProjectPreviewModel(
        id: id,
        membersCount: 1,
        name: provider.name,
        role: ProjectRole.owner,
      );

      homeProvider.addProject(projectPreview);
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

  Widget _buildCreateButton() => Builder(
        builder: (BuildContext context) => ElevatedButton(
          onPressed: () async => _onClickCreate(context),
          child: const Text('Créer'),
        ),
      );

  TextButton _buildCancelButton() => const TextButton(
        onPressed: Navigation.pop,
        child: Text('Annuler'),
      );

  Widget _nameField(TextEditingController controller) => TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(hintText: 'Nom du projet'),
        controller: controller,
        validator: (String? value) => ValidatorHelper.isNullOrEmpty(
          value,
          'Le nom du projet ne peut pas être vide.',
        ),
      );

  void _onValueChanged(BuildContext context, String value) {
    context.read<CreateProjectProvider>().name = value;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      () => controller
          .onValueChanged((String value) => _onValueChanged(context, value)),
    );

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: context.read<CreateProjectProvider>().formKey,
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
                    _buildCancelButton(),
                    _buildCreateButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
