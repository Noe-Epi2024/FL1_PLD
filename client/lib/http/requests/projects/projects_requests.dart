import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/http/routes.dart';
import 'package:hyper_tools/models/projects_model.dart';

class GetProjects extends GetRequest<ProjectsModel> {
  @override
  ProjectsModel builder(Map<String, dynamic> json) =>
      ProjectsModel.fromJson(json);

  @override
  Uri get uri => Routes.projectAll;

  @override
  bool get private => true;
}
