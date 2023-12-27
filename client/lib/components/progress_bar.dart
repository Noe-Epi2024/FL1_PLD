import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class TaskProgressBar extends HookWidget {
  const TaskProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 1));
    final int progressPercent = context.select<TaskProvider, int>(
      (TaskProvider provider) => provider.progressPercent!,
    );
    final double currentValue = useAnimation(controller);

    useEffect(
      () {
        controller.animateTo(
          progressPercent / 100.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
        return () {};
      },
      <int?>[progressPercent],
    );

    return LinearProgressIndicator(minHeight: 20, value: currentValue);
  }
}
