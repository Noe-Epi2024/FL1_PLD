import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/http/requests/project/member/get_project_members.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/task/components/members/members_provider.dart';
import 'package:provider/provider.dart';

class ProjectMembersTab extends StatelessWidget {
  const ProjectMembersTab({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProjectMembersProvider>(
        create: (_) => ProjectMembersProvider(),
        child: _ProjecMembersTabBuilder(
          projectId: projectId,
        ),
      );
}

class _ProjecMembersTabBuilder extends HookWidget {
  const _ProjecMembersTabBuilder({required this.projectId});

  final String projectId;

  void _onSearchChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<ProjectMembersProvider>().filter = controller.text;
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onSearchChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
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

  Widget _roleIcon(BuildContext context, ProjectRole role, bool isUserRole) =>
      IconButton(
        onPressed: () {},
        icon: Icon(
          role.icon,
          color: isUserRole
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).hintColor,
          size: 24,
        ),
      );

  void _onClickDelete(BuildContext context) {}

  SlidableAction _deleteButton() => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  Widget _member(BuildContext context, String memberId) {
    final ProjectMemberModel member =
        context.watch<ProjectMembersProvider>().findMember(memberId);

    final ProjectRole role = member.role;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: <Widget>[_deleteButton()],
      ),
      child: Card(
        margin: 4.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                member.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  _roleIcon(
                    context,
                    ProjectRole.owner,
                    role == ProjectRole.owner,
                  ),
                  _roleIcon(
                    context,
                    ProjectRole.writer,
                    role == ProjectRole.writer,
                  ),
                  _roleIcon(
                    context,
                    ProjectRole.reader,
                    role == ProjectRole.reader,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _membersList(BuildContext context) {
    final List<ProjectMemberModel> members =
        context.watch<ProjectMembersProvider>().members!.members;

    final String filter = context.select<ProjectMembersProvider, String>(
      (ProjectMembersProvider provider) => provider.filter,
    );

    return members
        .where((ProjectMemberModel member) => member.name.contains(filter))
        .map((ProjectMemberModel member) => _member(context, member.userId))
        .toList();
  }

  TextField _searchBar(BuildContext context, TextEditingController controller) {
    final String filter = context.select<ProjectMembersProvider, String>(
      (ProjectMembersProvider provider) => provider.filter,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Chercher un projet',
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(() => _initializeController(context, controller));

    return ProviderResolver<ProjectMembersProvider>.future(
      future: () async => _loadMembers(context),
      builder: (BuildContext resolverContext) => ListView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 30,
          bottom: 100,
        ),
        children: <Widget>[
          const TitleText('Membres'),
          _searchBar(resolverContext, controller),
          8.height,
          ..._membersList(resolverContext),
        ],
      ),
    );
  }
}
