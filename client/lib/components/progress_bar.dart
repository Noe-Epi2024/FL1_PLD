import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.initialValue,
    required this.height,
    super.key,
  });

  final double initialValue;
  final double height;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProgressBarProvider>(
        create: (_) => ProgressBarProvider(initialValue),
        child: _ProgressBarBuilder(initialValue: initialValue, height: height),
      );
}

class _ProgressBarBuilder extends HookWidget {
  const _ProgressBarBuilder({
    required this.initialValue,
    required this.height,
  });

  final double initialValue;
  final double height;

  FractionallySizedBox _progressBar(BuildContext context) =>
      FractionallySizedBox(
        widthFactor: initialValue,
        heightFactor: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final double value = useAnimation(controller);

    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.background,
      ),
      alignment: Alignment.centerLeft,
      child: _progressBar(context),
    );
  }
}

class ProgressBarProvider with ChangeNotifier {
  ProgressBarProvider(double initialValue) : _value = initialValue;

  double _value;

  double get value => _value;

  set value(double v) {
    _value = v;
    notifyListeners();
  }
}

class ProgressBarController {
  AnimationController? animationController;

  void setAnimationValue(double value) {
    if (animationController == null) return;

    final double oldValue = animationController!.value;

    animationController!.value = value;
  }
}
