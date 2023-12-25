import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/user/patch_me.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/profile/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileEmail extends HookWidget {
  const ProfileEmail({super.key});

  void _onEmailChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<ProfileProvider>().currentEmail = controller.text;
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onEmailChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  Future<void> _onClickSave(BuildContext context) async {
    try {
      final String? email = context.read<ProfileProvider>().currentEmail;

      await PatchMe(email: email).patch();

      context.read<ProfileProvider>().setEmail(email!);

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);

      FocusScope.of(context).unfocus();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _saveButton(BuildContext context) {
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
  }

  TextField _textField(
    BuildContext context,
    TextEditingController controller,
  ) =>
      TextField(
        style: Theme.of(context).appBarTheme.titleTextStyle,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        decoration: const InputDecoration(
            hintText: 'Écrire votre email',
            prefixIcon: Icon(Boxicons.bx_envelope)),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.read<ProfileProvider>().me?.email,
    );

    useEffect(() => _initializeController(context, controller));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _textField(context, controller)),
        _saveButton(context),
      ],
    );
  }
}
