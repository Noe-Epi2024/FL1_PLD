import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';

class TaskProvider extends ProviderBase {
  TaskProvider() : super(isInitiallyLoading: true);

  TaskModel? _task;

  TaskModel? get task => _task;

  set task(TaskModel? value) {
    _task = value;
    notifyListeners();
  }
}
