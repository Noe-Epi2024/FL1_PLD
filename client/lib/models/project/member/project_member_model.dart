class ProjectMemberModel {
  ProjectMemberModel({
    required this.userId,
    required this.role,
    required this.name,
  });

  factory ProjectMemberModel.fromJson(Map<String, dynamic> json) =>
      ProjectMemberModel(
        userId: json['userId'],
        role: json['role'],
        name: json['name'],
      );

  final String userId;
  final String role;
  final String name;
}
