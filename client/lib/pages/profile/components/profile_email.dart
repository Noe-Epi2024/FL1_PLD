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

class ProfileEmail extends HookWidget {
  const ProfileEmail({super.key});

  void _onEmailChanged(BuildContext context, String email) {
    context.read<ProfileProvider>().currentEmail = email;
  }

  Future<void> _onClickSave(BuildContext context) async {
    final ProfileProvider provider = context.read<ProfileProvider>();

    try {
      final String? email = provider.currentEmail;

      await PatchMe(email: email).send();

      provider.setEmail(email!);

      if (context.mounted) {
        FocusScope.of(context).unfocus();
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
      }
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _buildSaveButton() => Builder(
        builder: (BuildContext context) {
          final ProfileProvider provider = context.watch<ProfileProvider>();

          if (provider.currentEmail != null &&
              provider.currentEmail!.isNotEmpty &&
              provider.currentEmail != provider.me?.email) {
            return TextButton(
              onPressed: () async => _onClickSave(context),
              child: const Text('Enregistrer'),
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _buildEmailTextField(TextEditingController controller) => Builder(
        builder: (BuildContext context) => TextField(
          style: Theme.of(context).appBarTheme.titleTextStyle,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Écrire votre email',
            prefixIcon: TextFieldIcon(FontAwesomeIcons.solidEnvelope),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.read<ProfileProvider>().me?.email,
    );

    useEffect(
      controller
          .onValueChanged((String value) => _onEmailChanged(context, value)),
      <Object?>[],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _buildEmailTextField(controller)),
        _buildSaveButton(),
      ],
    );
  }
}
