import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/post_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class CreateSubtaskField extends StatelessWidget {
  const CreateSubtaskField({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SubtaskProvider>(
        create: (_) => SubtaskProvider(initialName: ''),
        child: _CreateSubtaskFieldBuilder(projectId: projectId, taskId: taskId),
      );
}

class _CreateSubtaskFieldBuilder extends HookWidget {
  const _CreateSubtaskFieldBuilder({
    required this.projectId,
    required this.taskId,
  });

  final String projectId;
  final String taskId;

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onNameChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  void _onNameChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<SubtaskProvider>().currentName = controller.text;
  }

  Future<void> _onClickCreate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    try {
      final String subtaskId = await PostSubtask(
        projectId: projectId,
        taskId: taskId,
        name: controller.text,
      ).post();

      final SubtaskModel subtask =
          SubtaskModel(id: subtaskId, name: controller.text);

      context.read<TaskProvider>().addSubtask(subtask);

      controller.clear();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _createButton(
    BuildContext context,
    TextEditingController controller,
  ) =>
      TextButton(
        style:
            const ButtonStyle(shape: MaterialStatePropertyAll(CircleBorder())),
        onPressed: () async => _onClickCreate(context, controller),
        child: const Text('Ajouter'),
      );

  TextField _nameField(TextEditingController controller) => TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.add),
          hintText: 'Ajouter une sous-tâche',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        controller: controller,
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(() => _initializeController(context, controller));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(child: _nameField(controller)),
          if (context
                  .select<SubtaskProvider, String?>(
                    (SubtaskProvider provider) => provider.currentName,
                  )
                  ?.isNotEmpty ??
              false)
            _createButton(context, controller),
        ],
      ),
    );
  }
}
