import "../../../models/projects_model.dart";
import "../../routes.dart";
import "../get_request.dart";

class GetProjects extends GetRequest<ProjectsModel> {
  @override
  ProjectsModel builder(Map<String, dynamic> json) =>
      ProjectsModel.fromJson(json);

  @override
  Uri get uri => Routes.projectAll;

  @override
  bool get private => true;
}
