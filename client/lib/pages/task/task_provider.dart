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

  void setSubtaskIsDone({required String subtaskId, required bool value}) {
    if (task == null) return;

    task!.substasks
        .firstWhere((SubtaskModel subtask) => subtask.id == subtaskId)
        .isDone = value;

    notifyListeners();
  }

  void deleteSubtask({required String subtaskId}) {
    if (task == null) return;

    task!.substasks
        .removeWhere((SubtaskModel subtask) => subtask.id == subtaskId);

    notifyListeners();
  }
}
