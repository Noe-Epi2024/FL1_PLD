import 'package:flutter/material.dart';
import 'package:hyper_tools/components/provider/provider_base.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class ProjectProvider extends ProviderBase {
  ProjectProvider(this.context, {required this.projectId})
      : super(isInitiallyLoading: true);

  final BuildContext context;
  final String projectId;

  ProjectModel? _project;

  ProjectModel? get project => _project;

  set project(ProjectModel? value) {
    _project = value;
    notifyListeners();
  }

  TaskPreviewModel? findTaskPreview(String taskId) => project?.taskPreviews
      .firstWhere((TaskPreviewModel taskPreview) => taskPreview.id == taskId);

  int? get progress {
    if ((project?.taskPreviews ?? <TaskPreviewModel>[]).isEmpty) return null;

    int total = 0;
    int cpt = 0;

    for (final TaskPreviewModel taskPreview in project!.taskPreviews) {
      final int? taskProgress = getTaskProgress(taskPreview.id);

      if (taskProgress == null) continue;

      total += taskProgress * taskPreview.numberOfSubtasks;
      cpt += taskPreview.numberOfSubtasks;
    }

    if (cpt == 0) return null;

    return (total / cpt).ceil();
  }

  int? getTaskProgress(String taskId) {
    final TaskPreviewModel? task = findTaskPreview(taskId);

    if (task == null) return null;

    if (task.numberOfSubtasks == 0) return 0;

    return (task.numberOfCompletedSubtasks / task.numberOfSubtasks * 100)
        .ceil();
  }

  void setTaskStartDate({required String taskId, required DateTime? date}) {
    if (_project == null) return;

    findTaskPreview(taskId)?.startDate = date;

    notifyListeners();
  }

  void setTaskEndDate({required String taskId, required DateTime? date}) {
    if (_project == null) return;

    findTaskPreview(taskId)?.endDate = date;

    notifyListeners();
  }

  void setTaskName({required String taskId, required String? name}) {
    if (_project == null) return;

    findTaskPreview(taskId)?.name = name;

    notifyListeners();
  }

  void setTaskOwner({required String taskId, required String? name}) {
    if (project == null) return;

    findTaskPreview(taskId)?.ownerName = name;

    notifyListeners();
  }

  void setTaskProgress({
    required String taskId,
    required int numberOfCompletedSubtasks,
    required int numberOfSubtasks,
  }) {
    if (project == null) return;

    findTaskPreview(taskId)
      ?..numberOfCompletedSubtasks = numberOfCompletedSubtasks
      ..numberOfSubtasks = numberOfSubtasks;
    onTasksChanged();

    notifyListeners();
  }

  void addTaskPreview(TaskPreviewModel taskPreview) {
    if (project == null) return;

    _project!.taskPreviews.add(taskPreview);
    onTasksChanged();

    notifyListeners();
  }

  void deleteTaskPreview(String taskId) {
    if (project == null) return;

    _project!.taskPreviews.removeWhere(
      (TaskPreviewModel taskPreview) => taskPreview.id == taskId,
    );
    onTasksChanged();

    notifyListeners();
  }

  void setName(String name) {
    if (project == null) return;

    _project!.name = name;
    context
        .read<HomeProvider>()
        .setProjectName(projectId: projectId, name: name);

    notifyListeners();
  }

  void onTasksChanged() {
    context
        .read<HomeProvider>()
        .setProjectProgress(projectId: projectId, progress: progress);
  }

  void setSuccessState(ProjectModel value) {
    _project = value;
    isLoading_ = false;

    notifyListeners();
  }
}
