import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/Patch_request.dart';

class PatchProjectMember extends PatchRequest<void> {
  PatchProjectMember({required this.projectId, this.userId, this.userRole});

  final String projectId;
  final String? userId;
  final String? userRole;

  @override
  Map<String, dynamic> get body => <String, dynamic>{
        if (userId != null) 'userId': userId,
        if (userRole != null) 'role': userRole,
      };

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/member');
}
