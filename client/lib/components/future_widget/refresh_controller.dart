import 'package:hyper_tools/components/future_widget/i_refreshable.dart';

/// Allows external manupulation of a [IRefreshable] such as [refresh]ing it.
class RefreshController {
  IRefreshable? _target;

  void initialize(IRefreshable state) {
    _target = state;
  }

  void refresh() {
    _target?.refresh();
  }
}
