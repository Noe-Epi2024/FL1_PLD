import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/projects_model.dart';

class GetProjects extends GetRequest<ProjectsModel> {
  @override
  ProjectsModel builder(Map<String, dynamic> json) =>
      ProjectsModel.fromJson(json);

  @override
  Uri get uri => RouteHelper.buildUri('project/project/all');

  @override
  bool get private => true;
}
