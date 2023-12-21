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
        role: json['role'],
        progress: json['progress'],
      );

  final String id;
  final String name;
  final int membersCount;
  final String role;
  final int? progress;
}
