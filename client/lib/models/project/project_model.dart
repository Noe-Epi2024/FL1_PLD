import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';

class ProjectModel {
  ProjectModel({
    required this.id,
    required this.name,
    required this.role,
    required this.taskPreviews,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        name: json['name'],
        role: ProjectRole.parse(json['role']),
        taskPreviews: List<Map<String, dynamic>>.from(json['tasks'])
            .map(TaskPreviewModel.fromJson)
            .toList(),
      );

  final String id;
  String name;
  ProjectRole role;
  List<TaskPreviewModel> taskPreviews;
}
