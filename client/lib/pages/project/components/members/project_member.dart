import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/member/delete_project_member.dart';
import 'package:hyper_tools/http/requests/project/member/patch_project_member.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/members/members_provider.dart';
import 'package:provider/provider.dart';

class ProjectMember extends StatelessWidget {
  const ProjectMember({
    required this.memberId,
    required this.projectId,
    super.key,
  });

  final String projectId;
  final String memberId;

  Future<void> _onClickDelete(BuildContext context) async {
    try {
      await DeleteProjectMember(projectId: projectId, userId: memberId)
          .delete();

      Messenger.showSnackBarQuickInfo('Supprimé', context);

      context.read<ProjectMembersProvider>().deleteMember(memberId);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Future<void> _onClickRole(BuildContext context, ProjectRole role) async {
    try {
      await PatchProjectMember(
        projectId: projectId,
        userId: memberId,
        userRole: role,
      ).patch();

      Messenger.showSnackBarQuickInfo('Rôle modifié', context);

      context.read<ProjectMembersProvider>().setMemberRole(memberId, role);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  SlidableAction _deleteButton(BuildContext context) => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  Widget _roleIcon(BuildContext context, ProjectRole role, bool isUserRole) =>
      IconButton(
        onPressed: isUserRole ? null : () async => _onClickRole(context, role),
        icon: Icon(
          role.icon,
          color: isUserRole
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).hintColor,
          size: 24,
        ),
      );

  Widget _icons(BuildContext context) {
    final ProjectRole userRole = context.read<ProjectProvider>().project!.role;

    final ProjectMemberModel member =
        context.read<ProjectMembersProvider>().findMember(memberId);

    final ProjectRole role = member.role;

    if (userRole != ProjectRole.owner) {
      return Padding(
        padding: 16.all,
        child: Icon(
          role.icon,
          color: Theme.of(context).hintColor,
          size: 24,
        ),
      );
    }

    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name =
        context.read<ProjectMembersProvider>().findMember(memberId).name;

    final ProjectRole role = context.read<ProjectProvider>().project!.role;

    return Slidable(
      endActionPane: RoleHelper.canManageMembers(role)
          ? ActionPane(
              motion: const ScrollMotion(),
              children: <Widget>[_deleteButton(context)],
            )
          : null,
      child: Card(
        margin: 4.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              _icons(context),
            ],
          ),
        ),
      ),
    );
  }
}
