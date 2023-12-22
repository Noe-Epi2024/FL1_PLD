import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';

class GetProjectMembers extends GetRequest<ProjectMembersModel> {
  GetProjectMembers({required this.projectId});

  final String projectId;

  @override
  ProjectMembersModel builder(Map<String, dynamic> json) =>
      ProjectMembersModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/member');
}
