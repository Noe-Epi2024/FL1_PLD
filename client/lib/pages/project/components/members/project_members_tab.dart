import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/member/get_project_members.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';
import 'package:hyper_tools/pages/project/components/members/add/add_project_member_modal.dart';
import 'package:hyper_tools/pages/project/components/members/project_member.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/members/members_provider.dart';
import 'package:provider/provider.dart';

class ProjectMembersTab extends StatelessWidget {
  const ProjectMembersTab({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProjectMembersProvider>(
        create: (_) => ProjectMembersProvider(context, projectId: projectId),
        child: _ProjecMembersTabBuilder(
          projectId: projectId,
        ),
      );
}

class _ProjecMembersTabBuilder extends HookWidget {
  const _ProjecMembersTabBuilder({required this.projectId});

  final String projectId;

  void _onSearchChanged(BuildContext context, String filter) {
    context.read<ProjectMembersProvider>().filter = filter;
  }

  Future<void> _onClickAddMember(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<ProjectMembersProvider>.value(
        value: context.read<ProjectMembersProvider>(),
        builder: (__, ___) => AddProjectMemberModal(projectId: projectId),
      ),
    );
  }

  Future<void> _loadMembers(BuildContext context) async {
    try {
      final ProjectMembersModel members =
          await GetProjectMembers(projectId: projectId).get();

      context.read<ProjectMembersProvider>()
        ..members = members
        ..isLoading = false;
    } on ErrorModel catch (e) {
      context.read<ProjectMembersProvider>().setErrorState(e);
    }
  }

  List<Widget> _membersList(BuildContext context) {
    final List<ProjectMemberModel> members =
        context.watch<ProjectMembersProvider>().members!.members;

    final String filter = context.select<ProjectMembersProvider, String>(
      (ProjectMembersProvider provider) => provider.filter,
    );

    return members
        .where(
          (ProjectMemberModel member) =>
              member.name.toLowerCase().contains(filter.toLowerCase()),
        )
        .map(
          (ProjectMemberModel member) =>
              ProjectMember(memberId: member.userId, projectId: projectId),
        )
        .toList();
  }

  TextField _searchBar(BuildContext context, TextEditingController controller) {
    final String filter = context.select<ProjectMembersProvider, String>(
      (ProjectMembersProvider provider) => provider.filter,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Chercher un membre',
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
  }

  Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () async => _onClickAddMember(context),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    useAutomaticKeepAlive();

    useEffect(
      controller
          .onValueChanged((String value) => _onSearchChanged(context, value)),
    );

    return ProviderResolver<ProjectMembersProvider>.future(
      future: () async => _loadMembers(context),
      builder: (BuildContext resolverContext) => Scaffold(
        floatingActionButton: RoleHelper.canManageMembers(
          context.read<ProjectProvider>().project!.role,
        )
            ? _floatingActionButton(context)
            : null,
        body: ListView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 30,
            bottom: 128,
          ),
          children: <Widget>[
            const TitleText('Membres'),
            8.height,
            _searchBar(resolverContext, controller),
            8.height,
            ..._membersList(resolverContext),
          ],
        ),
      ),
    );
  }
}
