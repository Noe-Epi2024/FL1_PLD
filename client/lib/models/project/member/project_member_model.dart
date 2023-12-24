import 'package:hyper_tools/models/project/project_role.dart';

class ProjectMemberModel {
  ProjectMemberModel({
    required this.userId,
    required this.role,
    required this.name,
  });

  factory ProjectMemberModel.fromJson(Map<String, dynamic> json) =>
      ProjectMemberModel(
        userId: json['userId'],
        role: ProjectRole.parse(json['role']),
        name: json['name'],
      );

  final String userId;
  final String name;
  ProjectRole role;
}
