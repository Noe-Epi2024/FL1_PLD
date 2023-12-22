import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/patch_request.dart';

class PatchSubtask extends PatchRequest<void> {
  PatchSubtask({
    required this.projectId,
    required this.taskId,
    required this.subtaskId,
    this.isDone,
    this.name,
  });

  final String projectId;
  final String taskId;
  final String subtaskId;
  final String? name;
  final bool? isDone;

  @override
  Map<String, dynamic>? get body => <String, dynamic>{
        if (isDone != null) 'isDone': isDone,
        if (name != null) 'name': name,
      };

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri(
        'project/$projectId/task/$taskId/subtask/$subtaskId',
      );
}
