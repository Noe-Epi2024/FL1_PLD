import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/delete_request.dart';

class DeleteProjectMember extends DeleteRequest<void> {
  DeleteProjectMember({required this.projectId, required this.userId});

  final String projectId;
  final String userId;

  @override
  Map<String, dynamic> get body => <String, dynamic>{'userId': userId};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/member');
}
