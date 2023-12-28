import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/user/patch_me.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/profile/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileName extends HookWidget {
  const ProfileName({super.key});

  void _onNameChanged(BuildContext context, String name) {
    context.read<ProfileProvider>().currentName = name;
  }

  Future<void> _onClickSave(BuildContext context) async {
    final ProfileProvider provider = context.read<ProfileProvider>();

    try {
      final String? name = provider.currentName;

      await PatchMe(name: name).patch();

      provider.setName(name!);

      if (context.mounted) {
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
        FocusScope.of(context).unfocus();
      }
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _buildSaveButton() => Builder(
        builder: (BuildContext context) {
          final ProfileProvider provider = context.watch<ProfileProvider>();

          if (provider.currentName != null &&
              provider.currentName!.isNotEmpty &&
              provider.currentName != provider.me?.name) {
            return TextButton(
              onPressed: () async => _onClickSave(context),
              child: const Text('Enregistrer'),
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _buildNameTextField(TextEditingController controller) => Builder(
        builder: (BuildContext context) => TextField(
          style: Theme.of(context).appBarTheme.titleTextStyle,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Écrire votre nom',
            prefixIcon: TextFieldIcon(FontAwesomeIcons.solidUser),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.read<ProfileProvider>().me?.name,
    );

    useEffect(
      controller
          .onValueChanged((String value) => _onNameChanged(context, value)),
      <Object?>[],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _buildNameTextField(controller)),
        _buildSaveButton(),
      ],
    );
  }
}
