import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/delete_request.dart';

class DeleteTask extends DeleteRequest<void> {
  DeleteTask({required this.projectId, required this.taskId});

  final String projectId;
  final String taskId;

  @override
  Map<String, dynamic>? get body => <String, dynamic>{'taskId': taskId};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/task');
}
