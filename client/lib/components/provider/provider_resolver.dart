import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/provider/provider_base.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:provider/provider.dart';

class ProviderResolver<T extends ProviderBase> extends HookWidget {
  const ProviderResolver({
    required this.builder,
    this.loader,
    super.key,
  });

  final Widget Function(BuildContext) builder;
  final Widget? loader;

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        context.select<T, bool>((T provider) => provider.isLoading);
    final ErrorModel? error =
        context.select<T, ErrorModel?>((T provider) => provider.error);

    if (isLoading) {
      return loader ?? const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text(error.errorMessage));
    }
    return builder(context);
  }
}
