import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/post_request.dart';
import 'package:hyper_tools/models/project/project_role.dart';

class PostProjectMember extends PostRequest<void> {
  PostProjectMember({
    required this.projectId,
    required this.userId,
    required this.userRole,
  });

  final String projectId;
  final String userId;
  final ProjectRole userRole;

  @override
  Map<String, dynamic> get body =>
      <String, dynamic>{'userId': userId, 'role': userRole.name};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/member');
}
