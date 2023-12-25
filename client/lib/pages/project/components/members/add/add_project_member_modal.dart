import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/shimmer_placeholder.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
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

  Future<void> _loadEntries(BuildContext context, IsMounted isMounted) async {
    final AddProjectMemberModalProvider provider =
        context.read<AddProjectMemberModalProvider>();

    try {
      final UsersModel users =
          await GetUsers(excludeProjectId: projectId, filter: provider.filter)
              .get();

      if (isMounted()) provider.setSuccessState(users);
    } on ErrorModel catch (e) {
      if (isMounted()) provider.setErrorState(e);
    }
  }

  void _onSearchChanged(
    BuildContext context,
    TextEditingController controller,
    IsMounted isMounted,
  ) {
    context.read<AddProjectMemberModalProvider>().filter = controller.text;

    if (controller.text.isNotEmpty) {
      unawaited(_loadEntries(context, isMounted));
    } else {
      if (isMounted()) {
        context.read<AddProjectMemberModalProvider>().setSuccessState(null);
      }
    }
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
    IsMounted isMounted,
  ) {
    void listener() => _onSearchChanged(context, controller, isMounted);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  TitleText get _title => const TitleText('Inviter un membre');

  TextField _searchBar(BuildContext context, TextEditingController controller) {
    final String filter = context.select<AddProjectMemberModalProvider, String>(
      (AddProjectMemberModalProvider provider) => provider.filter,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Nom d'utilisateur",
        prefixIcon: const Icon(Boxicons.bx_search),
        suffixIcon: filter.isEmpty
            ? null
            : TextButton(
                onPressed: controller.clear,
                child: Icon(
                  Boxicons.bxs_x_circle,
                  color: Theme.of(context).hintColor,
                ),
              ),
      ),
    );
  }

  Widget _loader() => ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: 8.vertical,
          child: const ShimmerPlaceholder(
            width: 50,
            height: 20,
          ),
        ),
      );

  Widget _entries(BuildContext context) {
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
              userId: user.id,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final IsMounted isMounted = useIsMounted();

    useEffect(() => _initializeController(context, controller, isMounted));

    return Dialog(
      child: Padding(
        padding: 32.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _title,
            16.height,
            _searchBar(context, controller),
            16.height,
            ProviderResolver<AddProjectMemberModalProvider>(builder: _entries),
          ],
        ),
      ),
    );
  }
}
