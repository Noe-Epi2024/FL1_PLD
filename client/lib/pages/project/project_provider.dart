import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';

class ProjectProvider extends ProviderBase {
  ProjectProvider() : super(isInitiallyLoading: true);

  ProjectModel? _project;

  ProjectModel? get project => _project;

  set project(ProjectModel? value) {
    _project = value;
    notifyListeners();
  }

  void setTaskStartDate({required String taskId, required DateTime date}) {
    if (_project == null) return;

    _project!.taskPreviews
        .firstWhere((TaskPreviewModel taskPreview) => taskPreview.id == taskId)
        .startDate = date;

    notifyListeners();
  }

  void setTaskEndDate({required String taskId, required DateTime date}) {
    if (_project == null) return;

    _project!.taskPreviews
        .firstWhere((TaskPreviewModel taskPreview) => taskPreview.id == taskId)
        .endDate = date;

    notifyListeners();
  }

  void setTaskOwner({required String taskId, required String name}) {
    if (project == null) return;

    project!.taskPreviews
        .firstWhere((TaskPreviewModel task) => task.id == taskId)
        .ownerName = name;

    notifyListeners();
  }
}
