import 'package:flutter/material.dart';
import 'package:hyper_tools/components/dropdown/dropdown.dart';
import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/http/requests/project/member/get_project_members.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';

class ProjectMembersDropdown extends StatelessWidget {
  const ProjectMembersDropdown({required this.projectId, super.key});

  final String projectId;

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

  @override
  Widget build(BuildContext context) =>
      Dropdown<ProjectMemberModel>.lazy(fetch: _getMembers);
}
