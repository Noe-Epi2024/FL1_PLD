import 'package:hyper_tools/models/project/project_preview_model.dart';

class ProjectsModel {
  ProjectsModel({required this.projects, required this.name});

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        name: json['name'],
        projects: List<Map<String, dynamic>>.from(json['projects'])
            .map(ProjectPreviewModel.fromJson)
            .toList(),
      );

  final List<ProjectPreviewModel> projects;
  String name;
}
