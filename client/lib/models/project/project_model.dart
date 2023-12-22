import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';

class ProjectModel {
  ProjectModel({
    required this.id,
    required this.name,
    required this.role,
    required this.taskPreviews,
    this.progress,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        name: json['name'],
        taskPreviews: List<Map<String, dynamic>>.from(json['tasks'])
            .map(TaskPreviewModel.fromJson)
            .toList(),
        role: ProjectRole.parse(json['role']),
        progress: json['progress'],
      );

  final String id;
  final String name;
  final ProjectRole role;
  final List<TaskPreviewModel> taskPreviews;
  final int? progress;
}
