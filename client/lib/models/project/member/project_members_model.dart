import 'package:hyper_tools/models/project/member/project_member_model.dart';

class ProjectMembersModel {
  ProjectMembersModel({required this.members});

  factory ProjectMembersModel.fromJson(Map<String, dynamic> json) =>
      ProjectMembersModel(
        members: List<Map<String, dynamic>>.from(json['members'])
            .map(ProjectMemberModel.fromJson)
            .toList(),
      );

  List<ProjectMemberModel> members;
}
