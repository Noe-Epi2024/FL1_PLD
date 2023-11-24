import "../http/http.dart";
import "../http/routes.dart";
import "../models/authentication.model.dart";

class ProjectsService {
  static Future<AuthenticationModel> getAllProjects() => Http.get(
        Routes.projects,
        (data) => AuthenticationModel.fromJson(data),
        private: false,
      );
}
