import 'package:hyper_tools/models/project/project_role.dart';

class ProjectPreviewModel {
  ProjectPreviewModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.role,
    this.progress,
  });

  factory ProjectPreviewModel.fromJson(Map<String, dynamic> json) =>
      ProjectPreviewModel(
        id: json['id'],
        name: json['name'],
        membersCount: json['membersCount'],
        role: ProjectRole.parse(json['role']),
        progress: json['progress'],
      );

  final String id;
  final String name;
  final int membersCount;
  final ProjectRole role;
  final int? progress;
}
