import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/http/requests/user/get_users.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/user/user_model.dart';
import 'package:hyper_tools/models/user/users_model.dart';
import 'package:hyper_tools/pages/project/components/members/add/add_project_member_modal_entry.dart';
import 'package:hyper_tools/pages/project/components/members/add/add_project_member_modal_provider.dart';
import 'package:provider/provider.dart';

class AddProjectMemberModal extends StatelessWidget {
  const AddProjectMemberModal({required this.projectId, super.key});

  final String projectId;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AddProjectMemberModalProvider>(
        create: (_) => AddProjectMemberModalProvider(),
        child: _AddProjectMemberModalBuilder(projectId: projectId),
      );
}

class _AddProjectMemberModalBuilder extends HookWidget {
  const _AddProjectMemberModalBuilder({required this.projectId});

  final String projectId;

  Future<void> _loadEntries(BuildContext context) async {
    final AddProjectMemberModalProvider provider =
        context.read<AddProjectMemberModalProvider>();

    try {
      final UsersModel users =
          await GetUsers(excludeProjectId: projectId, filter: provider.filter)
              .send();

      provider.setSuccessState(users);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  void _onSearchChanged(BuildContext context, String filter) {
    context.read<AddProjectMemberModalProvider>().filter = filter;

    if (filter.isNotEmpty) {
      unawaited(_loadEntries(context));
    } else {
      context.read<AddProjectMemberModalProvider>().setSuccessState(null);
    }
  }

  TitleText get _title => const TitleText('Inviter un membre');

  Widget _buildSearchBar(TextEditingController controller) => Builder(
        builder: (BuildContext context) {
          final String filter =
              context.select<AddProjectMemberModalProvider, String>(
            (AddProjectMemberModalProvider provider) => provider.filter,
          );
          return TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Nom d'utilisateur",
              prefixIcon: const TextFieldIcon(FontAwesomeIcons.magnifyingGlass),
              suffixIcon: filter.isEmpty
                  ? null
                  : TextButton(
                      onPressed: controller.clear,
                      child: FaIcon(
                        FontAwesomeIcons.circleXmark,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
            ),
          );
        },
      );

  Widget _buildEntries() => Builder(
        builder: (BuildContext context) {
          final UsersModel? users =
              context.watch<AddProjectMemberModalProvider>().users;

          if (users == null || users.users.isEmpty) {
            return const Text('Pas de résultat');
          }

          return ListView(
            shrinkWrap: true,
            children: users.users
                .map(
                  (UserModel user) => AddProjectMemberModalEntry(
                    projectId: projectId,
                    user: user,
                  ),
                )
                .toList(),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      controller
          .onValueChanged((String value) => _onSearchChanged(context, value)),
      <Object?>[],
    );

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: 32.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _title,
              16.height,
              _buildSearchBar(controller),
              16.height,
              Expanded(
                child: ProviderResolver<AddProjectMemberModalProvider>(
                  builder: (_) => _buildEntries(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
