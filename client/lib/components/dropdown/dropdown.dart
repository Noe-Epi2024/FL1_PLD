import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/components/dropdown/dropdown_provider.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:provider/provider.dart';

part 'dropdown_route.dart';
part 'dropdown_list.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    required this.entries,
    super.key,
    this.onSelect,
    this.initialValue,
    this.labelText,
  })  : isLazy = false,
        fetch = null;

  const Dropdown.lazy({
    required this.fetch,
    super.key,
    this.onSelect,
    this.initialValue,
    this.labelText,
  })  : isLazy = true,
        entries = null;

  final List<DropdownEntry<T>>? entries;
  final DropdownEntry<T>? initialValue;
  final String? labelText;
  final void Function(T)? onSelect;
  final Future<List<DropdownEntry<T>>> Function()? fetch;
  final bool isLazy;

  Future<void> _onClick(BuildContext context) async {
    final DropdownProvider<T> provider = context.read<DropdownProvider<T>>();

    if (provider.isInitialized) {
      unawaited(_pushList(context));
    } else {
      try {
        provider.isLoading = true;

        unawaited(_pushList(context));

        final List<DropdownEntry<T>> fetchedEntries = await fetch!();

        provider
          ..entries = fetchedEntries
          ..isLoading = false
          ..isInitialized = true;
      } on ErrorModel catch (e) {
        provider
          ..error = e
          ..isLoading = false;
      }
    }
  }

  Future<Widget?> _pushList(BuildContext context) =>
      Navigator.of(context).push<Widget>(
        _DropdownRoute<Widget>(
          child: ChangeNotifierProvider<DropdownProvider<T>>.value(
            value: context.read<DropdownProvider<T>>(),
            child: _DropdownList<T>(onSelect: onSelect),
          ),
          parentOffset: (context.findRenderObject()! as RenderBox)
              .localToGlobal(Offset.zero),
          parentSize: (context.findRenderObject()! as RenderBox).size,
        ),
      );

  ElevatedButton _button(BuildContext context) => ElevatedButton(
        onPressed: () async => _onClick(context),
        child: Text(context.read<DropdownProvider<T>>().isLoading.toString()),
      );

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DropdownProvider<T>>(
        create: (_) => isLazy
            ? DropdownProvider<T>.lazy(initialValue: initialValue?.value)
            : DropdownProvider<T>(
                entries: entries!,
                initialValue: initialValue?.value,
              ),
        builder: (BuildContext providerContext, _) => _button(providerContext),
      );
}
