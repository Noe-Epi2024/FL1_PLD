import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

part 'future_widget_controller.dart';

class FutureWidget<T> extends StatefulWidget {
  /// Generic wrapper of [FutureBuilder] to provide more flexibility.
  /// Builds a Widget that will display a loading indicator while [future] is awaiting.
  /// If it completes with a success it will display [widget].
  /// If [future] fails, displays an error page : by default it will display the message of the error, [errorWidget] can be used to display a custom error instead.
  /// If [timeLimit] is specified, [future] will timeout once it reaches the time limit and display the error page.
  /// A [FutureWidgetController] can be assigned to a [FutureWidget] to allow external manipulation such as refreshing the [FutureWidget], aka invoking [future] again.
  /// Refreshing [FutureWidget] will start its whole life cycle from the beginning.
  const FutureWidget({
    required this.future,
    required this.widget,
    super.key,
    this.errorWidget,
    this.loader,
    this.controller,
    this.timeLimit = const Duration(seconds: 30),
    this.allowRefresh = true,
  });

  /// Function that returns the future that holds the value used to build the page.
  final Future<T> Function() future;

  /// Widget to build when [future] succeeds.
  final Widget Function(T data) widget;

  /// Widget to build when [future] fails.
  final Widget? errorWidget;

  /// Widget to build when [future] is waiting.
  final Widget? loader;

  /// Allows external manupulation of a [FutureWidget] such as [refresh]ing it.
  final FutureWidgetController<T>? controller;

  /// Duration to wait before the operation timeouts.
  final Duration timeLimit;

  /// Whether or not the page will show a refresh button to re-invoke the future in case of error or timeout.
  final bool allowRefresh;

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {
  /// Handles the state of the page built.
  late Completer<T> _completer;

  /// Handles the value of the current Future. Can be canceled if the request timeouts or if the page is disposed.
  late CancelableOperation<T> _cancelableOperation;

  /// Handles the timeout duration.
  late Timer _timer;

  /// Called by [FutureWidgetController] to refresh the page or when clicking the reload button on the error page.
  void _invokeFuture() {
    if (mounted) setState(_initialize);
  }

  /// Called when [_cancelableOperation] succeeds, ie when the [widget.future] succeeds.
  /// Calls whenComplete before completing the [_completer].
  void _onSuccess(T data) {
    if (_timer.isActive) _timer.cancel();
    if (!_completer.isCompleted) _completer.complete(data);
  }

  /// Called when [_cancelableOperation] fails, ie when the [widget.future] fails.
  void _onError(Object error, StackTrace _) {
    if (_timer.isActive) _timer.cancel();
    if (!_completer.isCompleted) _completer.completeError(error);
  }

  /// Initializes the state operation.
  Future<void> _initialize() async {
    // initializes the Completer that handles the content of page built
    _completer = Completer<T>();

    // initializes the CancelableOperation and makes it trigger _onSuccess and _onError if applicable
    _cancelableOperation = CancelableOperation<T>.fromFuture(widget.future());
    _cancelableOperation.then(_onSuccess, onError: _onError);

    // initializes the timeout Timer
    _timer = Timer(
      widget.timeLimit,
      () async => _cancel(reason: 'Timeout after ${widget.timeLimit}'),
    );
  }

  /// Called when the operation is canceled, ie when the widget is disposed or timeouts.
  Future<void> _cancel({String reason = 'Cancel'}) async {
    if (!_cancelableOperation.isCanceled) await _cancelableOperation.cancel();
    if (_timer.isActive) _timer.cancel();
    if (!_completer.isCompleted) _completer.completeError(reason);
  }

  /// Widget to display when the [CancelableOperation] returns an error, aka the future failed.
  Widget _error(String error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.error),
            Text(error),
            if (widget.allowRefresh)
              IconButton(
                onPressed: _invokeFuture,
                icon: const Icon(Icons.replay_outlined),
              ),
          ],
        ),
      );

  /// Widget to display when the [CancelableOperation] is still loading, aka the future is awaited.
  Widget get _loading => const Center(child: CircularProgressIndicator());

  /// Builds the state of the widget depending on the value hold by [snapshot].
  Widget _buildState(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return snapshot.hasError
          ? widget.errorWidget ?? _error(snapshot.error.toString())
          : widget.widget(snapshot.data as T);
    }
    // future in loading
    return widget.loader ?? _loading;
  }

  @override
  void dispose() {
    unawaited(_cancel());
    super.dispose();
  }

  @override
  void initState() {
    if (widget.controller != null) widget.controller!._state = this;
    unawaited(_initialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
        future: _completer.future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) =>
            _buildState(snapshot),
      );
}
