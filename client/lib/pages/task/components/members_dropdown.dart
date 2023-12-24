import 'package:flutter/material.dart';
import 'package:hyper_tools/components/dropdown/dropdown.dart';
import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/member/get_project_members.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class ProjectMembersDropdown extends StatelessWidget {
  const ProjectMembersDropdown({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  Future<List<DropdownEntry<ProjectMemberModel>>> _getMembers() async {
    final ProjectMembersModel members =
        await GetProjectMembers(projectId: projectId).get();

    return members.members
        .map(
          (ProjectMemberModel member) => DropdownEntry<ProjectMemberModel>(
            key: member.name,
            value: member,
          ),
        )
        .toList();
  }

  Future<bool> _onSelected(
    ProjectMemberModel member,
    BuildContext context,
  ) async {
    try {
      await PatchTask(
        projectId: projectId,
        taskId: taskId,
        ownerId: member.userId,
      ).patch();

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);

      context.read<ProjectProvider>()
        ..project!
            .taskPreviews
            .firstWhere((TaskPreviewModel task) => task.id == taskId)
            .ownerName = member.name
        ..notifyListeners();

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
      labelText: 'Membre',
      initialValue: DropdownEntry<ProjectMemberModel>(
        key: provider.task!.ownerName,
        value: ProjectMemberModel(
          name: provider.task!.ownerName,
          role: ProjectRole.owner,
          userId: provider.task!.ownerId,
        ),
      ),
      fetch: _getMembers,
      onSelect: (ProjectMemberModel member) async =>
          _onSelected(member, context),
    );
  }
}
