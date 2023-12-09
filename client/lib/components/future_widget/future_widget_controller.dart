part of "package:HyperTools/components/future_widget/future_widget.dart";

/// Allows external manupulation of a [FutureWidget] such as [refresh]ing it.
/// Refreshing [FutureWidget] will start its whole life cycle from the beginning.
class FutureWidgetController {
  _FutureWidgetState? _state;

  void refresh({bool noRebuild = false}) {
    if (noRebuild) {
      _state?._initialize();
    } else {
      _state?._invokeFuture();
    }
  }
}
