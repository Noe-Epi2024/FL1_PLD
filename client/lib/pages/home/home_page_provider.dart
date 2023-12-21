import 'package:hyper_tools/components/provider_base.dart';
import 'package:hyper_tools/models/projects_model.dart';

class HomePageProvider extends ProviderBase {
  HomePageProvider() : super(isInitiallyLoading: true);

  ProjectsModel? _projects;

  ProjectsModel? get projects => _projects;

  set projects(ProjectsModel? value) {
    _projects = value;
    notifyListeners();
  }

  String _filter = '';

  String get filter => _filter;

  set filter(String filter) {
    _filter = filter;
    notifyListeners();
  }
}
