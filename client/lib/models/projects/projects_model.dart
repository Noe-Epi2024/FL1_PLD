import 'package:hyper_tools/models/project/project_preview_model.dart';

class ProjectsModel {
  ProjectsModel({required this.projects});

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        projects: List<Map<String, dynamic>>.from(json['projects'])
            .map(ProjectPreviewModel.fromJson)
            .toList(),
      );

  final List<ProjectPreviewModel> projects;
}
