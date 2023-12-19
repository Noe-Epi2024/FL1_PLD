part of 'package:hyper_tools/components/future_widget/future_widget.dart';

/// Allows external manupulation of a [FutureWidget] such as [refresh]ing it.
/// Refreshing [FutureWidget] will start its whole life cycle from the beginning.
class FutureWidgetController<T> {
  _FutureWidgetState<T>? _state;

  Future<void> refresh({bool noRebuild = false}) async {
    if (noRebuild) {
      await _state?._initialize();
    } else {
      _state?._invokeFuture();
    }
  }
}
