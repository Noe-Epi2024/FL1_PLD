import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/delete_request.dart';

class DeleteSubtask extends DeleteRequest<void> {
  DeleteSubtask({
    required this.projectId,
    required this.taskId,
    required this.subtaskId,
  });

  final String projectId;
  final String taskId;
  final String subtaskId;

  @override
  Map<String, dynamic>? get body => <String, dynamic>{'subtaskId': subtaskId};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri =>
      RouteHelper.buildUri('project/$projectId/task/$taskId/subtask');
}
