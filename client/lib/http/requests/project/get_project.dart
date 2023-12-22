import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/project/project_model.dart';

class GetProject extends GetRequest<ProjectModel> {
  GetProject({required this.projectId});

  final String projectId;

  @override
  ProjectModel builder(Map<String, dynamic> json) =>
      ProjectModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId');
}
