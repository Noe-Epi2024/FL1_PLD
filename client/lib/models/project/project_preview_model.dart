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
  String name;
  int membersCount;
  ProjectRole role;
  int? progress;
}
