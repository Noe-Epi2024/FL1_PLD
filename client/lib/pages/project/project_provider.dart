import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/project_model.dart';

class ProjectProvider extends ProviderBase {
  ProjectProvider() : super(isInitiallyLoading: true);

  ProjectModel? _project;

  ProjectModel? get project => _project;

  set project(ProjectModel? value) {
    _project = value;
    notifyListeners();
  }
}
