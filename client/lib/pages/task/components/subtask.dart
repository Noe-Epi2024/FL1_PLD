import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';

class Subtask extends HookWidget {
  const Subtask(this.subtaskModel, {super.key});

  final SubtaskModel subtaskModel;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        useTextEditingController(text: subtaskModel.name);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _nameField(context, controller)),
        Checkbox(value: subtaskModel.isDone, onChanged: (bool? v) {}),
      ],
    );
  }

  TextField _nameField(
    BuildContext context,
    TextEditingController controller,
  ) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
}
