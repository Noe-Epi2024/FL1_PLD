import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/post_request.dart';

class PostSubtask extends PostRequest<String> {
  PostSubtask({
    required this.projectId,
    required this.taskId,
    required this.name,
  });

  final String projectId;
  final String taskId;
  final String name;

  @override
  Map<String, dynamic>? get body => <String, dynamic>{'name': name};

  @override
  String builder(Map<String, dynamic> json) => json['id'];

  @override
  bool get private => true;

  @override
  Uri get uri =>
      RouteHelper.buildUri('project/$projectId/task/$taskId/subtask');
}
