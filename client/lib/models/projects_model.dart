class ProjectsModel {
  final List<ProjectPreviewModel> projects;

  ProjectsModel({required this.projects});

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        projects: List.from(json["projects"])
            .map((e) => ProjectPreviewModel.fromJson(e))
            .toList(),
      );
}

class ProjectPreviewModel {
  final String id;
  final String name;
  final int membersCount;
  final String role;

  ProjectPreviewModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.role,
  });

  factory ProjectPreviewModel.fromJson(Map<String, dynamic> json) =>
      ProjectPreviewModel(
        id: json["id"],
        name: json["name"],
        membersCount: json["membersCount"],
        role: json["role"],
      );
}
