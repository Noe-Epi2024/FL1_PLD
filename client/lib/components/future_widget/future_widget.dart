// import 'dart:async';
// import 'package:async/async.dart';
// import 'package:flutter/material.dart';
// import 'package:hyper_tools/components/future_widget/i_refreshable.dart';
// import 'package:hyper_tools/components/future_widget/refresh_controller.dart';
// import 'package:hyper_tools/components/provider_base.dart';
// import 'package:provider/provider.dart';

// /// Generic wrapper of [FutureBuilder] to provide more flexibility.
// ///
// /// Builds a Widget that will display a loading indicator while [future] is awaiting.
// /// If it completes with a success it will display [widget].
// /// If [future] fails, displays an error page : by default it will display the message of the error, [errorWidget] can be used to display a custom error instead.
// /// If [timeLimit] is specified, [future] will timeout once it reaches the time limit and display the error page.
// /// A [RefreshController] can be assigned to a [FutureWidget] to allow external manipulation such as refreshing the [FutureWidget], aka invoking [future] again.
// /// Refreshing [FutureWidget] will start its whole life cycle from the beginning.
// ///
// /// T is the type of the value hold by this [FutureWidget].
// /// K is the type of the value hold by the [Provider] creates by this [FutureWidget].
// ///
// class FutureWidget<T, K extends ProviderBase> extends StatefulWidget {
//   const FutureWidget({
//     required this.future,
//     required this.create,
//     this.widget,
//     this.child,
//     super.key,
//     this.errorWidget,
//     this.loader,
//     this.controller,
//     this.timeLimit = const Duration(seconds: 30),
//     this.allowRefreshOnError = true,
//   }) : assert(
//           (widget != null || child != null) &&
//               !(widget != null && child != null),
//           'Either widget or child must be specified.',
//         );

//   /// Function that returns the future that holds the value used to build the page.
//   final Future<T> Function() future;

//   /// Widget to build when [future] succeeds.
//   final Widget Function(T data)? widget;

//   /// Widget to build when [future] succeeds.
//   final Widget? child;

//   /// Widget to build when [future] fails.
//   final Widget? errorWidget;

//   /// Widget to build when [future] is waiting.
//   final Widget? loader;

//   /// Function to create the provider.
//   final K Function(BuildContext) create;

//   /// Allows external manupulation of a [FutureWidget] such as refreshing it.
//   final RefreshController? controller;

//   /// Duration to wait before the operation timeouts.
//   final Duration timeLimit;

//   /// Whether or not the page will show a refresh button to re-invoke the future in case of error or timeout.
//   final bool allowRefreshOnError;

//   @override
//   State<FutureWidget<T, K>> createState() => _FutureWidgetState<T, K>();
// }

// class _FutureWidgetState<T, K extends ProviderBase>
//     extends State<FutureWidget<T, K>> implements IRefreshable {
//   /// Handles the state of the page built.
//   late Completer<T> _completer;

//   /// Handles the value of the current Future. Can be canceled if the request timeouts or if the page is disposed.
//   late CancelableOperation<T> _cancelableOperation;

//   /// Handles the timeout duration.
//   late Timer _timer;

//   /// Called by [RefreshController] to refresh the page or when clicking the reload button on the error page.
//   @override
//   void refresh() {
//     if (mounted) setState(_initialize);
//   }

//   /// Called when [_cancelableOperation] succeeds, ie when the [widget.future] succeeds.
//   /// Calls whenComplete before completing the [_completer].
//   void _onSuccess(T data) {
//     if (_timer.isActive) _timer.cancel();
//     if (!_completer.isCompleted) _completer.complete(data);
//   }

//   /// Called when [_cancelableOperation] fails, ie when the [widget.future] fails.
//   void _onError(Object error, StackTrace _) {
//     if (_timer.isActive) _timer.cancel();
//     if (!_completer.isCompleted) _completer.completeError(error);
//   }

//   /// Initializes the state operation.
//   Future<void> _initialize() async {
//     // initializes the Completer that handles the content of page built
//     _completer = Completer<T>();

//     // initializes the CancelableOperation and makes it trigger _onSuccess and _onError if applicable
//     _cancelableOperation = CancelableOperation<T>.fromFuture(widget.future());
//     _cancelableOperation.then(_onSuccess, onError: _onError);

//     // initializes the timeout Timer
//     _timer = Timer(
//       widget.timeLimit,
//       () async => _cancel(reason: 'Timeout after ${widget.timeLimit}'),
//     );
//   }

//   /// Called when the operation is canceled, ie when the widget is disposed or timeouts.
//   Future<void> _cancel({String reason = 'Cancel'}) async {
//     if (!_cancelableOperation.isCanceled) await _cancelableOperation.cancel();
//     if (_timer.isActive) _timer.cancel();
//     if (!_completer.isCompleted) _completer.completeError(reason);
//   }

//   /// Widget to display when the [CancelableOperation] returns an error, aka the future failed.
//   Widget _error(String error) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Icon(Icons.error),
//             Text(error),
//             if (widget.allowRefreshOnError)
//               IconButton(
//                 onPressed: refresh,
//                 icon: const Icon(Icons.replay_outlined),
//               ),
//           ],
//         ),
//       );

//   /// Widget to display when the [CancelableOperation] is still loading, aka the future is awaited.
//   Widget get _loading => const Center(child: CircularProgressIndicator());

//   /// Builds the state of the widget depending on the value hold by [snapshot].
//   Widget _buildState(BuildContext context) {

//     if () {
//       // future threw error
//       if (snapshot.hasError) {
//         return widget.errorWidget ?? _error(snapshot.error.toString());
//       }
//       // future completed successfully
//       return widget.widget?.call(snapshot.data as T) ?? widget.child!;
//     }
//     // future in loading
//     return widget.loader ?? _loading;
//   }

//   @override
//   void dispose() {
//     unawaited(_cancel());
//     super.dispose();
//   }

//   @override
//   void initState() {
//     widget.controller?.initialize(this);
//     unawaited(_initialize());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider<K>(
//         create: widget.create,
//         builder: (BuildContext context, Widget? widget) => FutureBuilder<T>(
//           future: _completer.future,
//           builder: (BuildContext context, AsyncSnapshot<T> snapshot) =>
//               _buildState(snapshot),
//         ),
//       );
// }
