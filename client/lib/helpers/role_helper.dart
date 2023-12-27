import 'package:hyper_tools/models/project/project_role.dart';

class RoleHelper {
  static bool canCreateTask(ProjectRole role) => role != ProjectRole.reader;

  static bool canEditTask(ProjectRole role) => role != ProjectRole.reader;

  static bool canEditProject(ProjectRole role) => role == ProjectRole.owner;

  static bool canManageMembers(ProjectRole role) =>
      role == ProjectRole.owner || role == ProjectRole.admin;

  static bool canLeaveProject(ProjectRole role) => role != ProjectRole.owner;

  static bool canDeleteProject(ProjectRole role) => role == ProjectRole.owner;
}
