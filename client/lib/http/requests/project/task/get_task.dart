import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';

class GetTask extends GetRequest<TaskModel> {
  GetTask({required this.projectId, required this.taskId});

  final String projectId;
  final String taskId;

  @override
  TaskModel builder(Map<String, dynamic> json) => TaskModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/task/$taskId');
}
