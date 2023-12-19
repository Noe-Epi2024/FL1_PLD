class ProjectsModel {
  ProjectsModel({required this.projects});

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        projects: List<Map<String, dynamic>>.from(json['projects'])
            .map(ProjectPreviewModel.fromJson)
            .toList(),
      );
  final List<ProjectPreviewModel> projects;
}

class ProjectPreviewModel {
  ProjectPreviewModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.role,
  });

  factory ProjectPreviewModel.fromJson(Map<String, dynamic> json) =>
      ProjectPreviewModel(
        id: json['id'],
        name: json['name'],
        membersCount: json['membersCount'],
        role: json['role'],
      );
  final String id;
  final String name;
  final int membersCount;
  final String role;
}
