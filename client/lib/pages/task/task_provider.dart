import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';

class TaskProvider extends ProviderBase {
  TaskProvider() : super(isInitiallyLoading: true);

  TaskModel? _task;

  TaskModel? get task => _task;

  set task(TaskModel? value) {
    _task = value;
    notifyListeners();
  }

  SubtaskModel? findSubtask(String id) =>
      _task?.substasks?.firstWhere((SubtaskModel subtask) => subtask.id == id);

  void setSubtaskIsDone({required String subtaskId, required bool value}) {
    if (task == null) return;

    findSubtask(subtaskId)?.isDone = value;

    notifyListeners();
  }

  void setSubtaskName({required String subtaskId, required String? value}) {
    if (task == null) return;

    findSubtask(subtaskId)?.name = value;

    notifyListeners();
  }

  void deleteSubtask({required String subtaskId}) {
    if (task?.substasks == null) return;

    _task?.substasks!
        .removeWhere((SubtaskModel subtask) => subtask.id == subtaskId);

    notifyListeners();
  }

  void addSubtask(SubtaskModel subtask) {
    if (task?.substasks == null) return;

    _task?.substasks!.add(subtask);

    notifyListeners();
  }

  void setDescription(String? description) {
    if (task == null) return;

    _task?.description = description;

    notifyListeners();
  }

  void setName(String? name) {
    if (task == null) return;

    _task?.name = name;

    notifyListeners();
  }

  void setStartDate(DateTime? startDate) {
    if (task == null) return;

    _task?.startDate = startDate;

    notifyListeners();
  }

  void setEndDate(DateTime? endDate) {
    if (task == null) return;

    _task?.endDate = endDate;

    notifyListeners();
  }

  double? get progress {
    if ((task?.substasks ?? <SubtaskModel>[]).isEmpty) return null;

    return task!.substasks!
            .where((SubtaskModel subtask) => subtask.isDone)
            .length /
        task!.substasks!.length;
  }
}
