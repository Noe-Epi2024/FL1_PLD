import 'package:flutter/material.dart';
import 'package:hyper_tools/components/dropdown/dropdown.dart';
import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/member/get_project_members.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class ProjectMembersDropdown extends StatelessWidget {
  const ProjectMembersDropdown({super.key});

  Future<List<DropdownEntry<ProjectMemberModel>>> _getMembers(
    BuildContext context,
  ) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      final ProjectMembersModel members =
          await GetProjectMembers(projectId: provider.projectId).send();

      return members.members
          .map(
            (ProjectMemberModel member) => DropdownEntry<ProjectMemberModel>(
              key: member.name,
              value: member,
            ),
          )
          .toList();
    } catch (_) {
      return <DropdownEntry<ProjectMemberModel>>[];
    }
  }

  Future<bool> _onSelected(
    ProjectMemberModel member,
    BuildContext context,
  ) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      await PatchTask(
        projectId: provider.projectId,
        taskId: provider.taskId,
        ownerId: member.userId,
      ).send();

      provider.setTaskOwner(member.name);

      if (context.mounted) {
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
      }

      return true;
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TaskProvider provider = context.read<TaskProvider>();

    return Dropdown<ProjectMemberModel>.lazy(
      readonly: !RoleHelper.canEditTask(
        context.read<ProjectProvider>().project!.role,
      ),
      labelText: 'Membre',
      initialValue:
          provider.task?.ownerId == null || provider.task?.ownerName == null
              ? null
              : DropdownEntry<ProjectMemberModel>(
                  key: provider.task!.ownerName!,
                  value: ProjectMemberModel(
                    name: provider.task!.ownerName!,
                    role: ProjectRole.owner,
                    userId: provider.task!.ownerId!,
                  ),
                ),
      fetch: () async => _getMembers(context),
      onSelect: (ProjectMemberModel member) async =>
          _onSelected(member, context),
    );
  }
}
