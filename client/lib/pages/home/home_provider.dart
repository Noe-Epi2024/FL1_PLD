import 'package:hyper_tools/components/provider/provider_base.dart';
import 'package:hyper_tools/models/project/project_preview_model.dart';
import 'package:hyper_tools/models/projects/projects_model.dart';

class HomeProvider extends ProviderBase {
  HomeProvider() : super(isInitiallyLoading: true);

  ProjectsModel? _projects;

  ProjectsModel? get projects => _projects;

  set projects(ProjectsModel? value) {
    _projects = value;

    notifyListeners();
  }

  String _filter = '';

  String get filter => _filter;

  ProjectPreviewModel? findProjectPreview(String projectId) =>
      projects?.projects.firstWhere(
        (ProjectPreviewModel projectPreview) => projectPreview.id == projectId,
      );

  set filter(String value) {
    _filter = value;

    notifyListeners();
  }

  void addProject(ProjectPreviewModel projectPreview) {
    if (_projects == null) return;

    _projects!.projects.add(projectPreview);

    notifyListeners();
  }

  void removeProject(String projectId) {
    if (_projects == null) return;

    _projects!.projects.remove(findProjectPreview(projectId));

    notifyListeners();
  }

  void setUserName(String value) {
    if (_projects == null) return;

    _projects!.name = value;

    notifyListeners();
  }

  void setProjectProgress({required String projectId, required int? progress}) {
    if (_projects == null) return;

    findProjectPreview(projectId)!.progress = progress;

    notifyListeners();
  }

  void setProjectName({required String projectId, required String name}) {
    if (_projects == null) return;

    findProjectPreview(projectId)!.name = name;

    notifyListeners();
  }

  void setProjectMembersCount({
    required String projectId,
    required int membersCount,
  }) {
    if (_projects == null) return;

    findProjectPreview(projectId)!.membersCount = membersCount;

    notifyListeners();
  }

  void setSuccessState(ProjectsModel value) {
    _projects = value;
    isLoading_ = false;

    notifyListeners();
  }
}
