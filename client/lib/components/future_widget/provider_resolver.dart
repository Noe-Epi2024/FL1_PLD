import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:provider/provider.dart';

class ProviderResolver<T extends ProviderBase> extends StatefulWidget {
  const ProviderResolver({
    required this.builder,
    this.loader,
    super.key,
  }) : future = null;

  const ProviderResolver.future({
    required this.builder,
    required this.future,
    this.loader,
    super.key,
  });

  final Widget Function(BuildContext) builder;
  final Future<dynamic> Function()? future;
  final Widget? loader;

  @override
  State<ProviderResolver<T>> createState() => _ProviderResolverState<T>();
}

class _ProviderResolverState<T extends ProviderBase>
    extends State<ProviderResolver<T>> {
  @override
  void initState() {
    if (widget.future != null) unawaited(widget.future!());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        context.select<T, bool>((T provider) => provider.isLoading);
    final ErrorModel? error =
        context.select<T, ErrorModel?>((T provider) => provider.error);

    if (isLoading) {
      return widget.loader ?? const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return const Center(child: Text('Error'));
    }
    return widget.builder(context);
  }
}
