import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/member/delete_project_member.dart';
import 'package:hyper_tools/http/requests/project/member/patch_project_member.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/members/members_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProjectMember extends StatelessWidget {
  const ProjectMember({
    required this.memberId,
    required this.projectId,
    super.key,
  });

  final String projectId;
  final String memberId;

  Future<void> _onClickDelete(BuildContext context) async {
    final ProjectMembersProvider provider =
        context.read<ProjectMembersProvider>();

    try {
      await DeleteProjectMember(projectId: projectId, userId: memberId).send();

      provider.deleteMember(memberId);

      if (context.mounted) Messenger.showSnackBarQuickInfo('Supprimé', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Future<void> _onClickRole(BuildContext context, ProjectRole role) async {
    final ProjectMembersProvider provider =
        context.read<ProjectMembersProvider>();

    try {
      await PatchProjectMember(
        projectId: projectId,
        userId: memberId,
        userRole: role,
      ).send();

      if (context.mounted) {
        Messenger.showSnackBarQuickInfo('Rôle modifié', context);
      }

      provider.setMemberRole(memberId, role);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  SlidableAction _buildDeleteButton() => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  Widget _buildRoleIcon(ProjectRole role) => Builder(
        builder: (BuildContext context) {
          final ProjectRole memberRole =
              context.read<ProjectMembersProvider>().findMember(memberId).role;

          return IconButton(
            onPressed: memberRole == role
                ? null
                : () async => _onClickRole(context, role),
            icon: FaIcon(
              role.icon,
              color: memberRole == role
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).hintColor,
              size: 20,
            ),
          );
        },
      );

  Widget _buildIcons() => Builder(
        builder: (BuildContext context) {
          final ProjectRole userRole =
              context.read<ProjectProvider>().project!.role;
          final ProjectRole memberRole =
              context.read<ProjectMembersProvider>().findMember(memberId).role;

          if (memberRole == ProjectRole.owner) {
            return Padding(
              padding: 12.all,
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 255, 204, 0),
                highlightColor: const Color.fromARGB(255, 255, 248, 151),
                child: FaIcon(
                  memberRole.icon,
                  size: 20,
                ),
              ),
            );
          }

          if (!RoleHelper.canManageMembers(userRole)) {
            return Padding(
              padding: 12.all,
              child: FaIcon(
                memberRole.icon,
                color: Theme.of(context).hintColor,
                size: 20,
              ),
            );
          }
          return Row(
            children: <Widget>[
              _buildRoleIcon(ProjectRole.admin),
              _buildRoleIcon(ProjectRole.writer),
              _buildRoleIcon(ProjectRole.reader),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final ProjectMembersProvider provider =
        context.read<ProjectMembersProvider>();

    final String name = provider.findMember(memberId).name;
    final ProjectRole memberRole = provider.findMember(memberId).role;
    final ProjectRole userRole = context.read<ProjectProvider>().project!.role;

    return Slidable(
      endActionPane: RoleHelper.canManageMembers(userRole) &&
              memberRole != ProjectRole.owner
          ? ActionPane(
              motion: const ScrollMotion(),
              children: <Widget>[_buildDeleteButton()],
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
              _buildIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
