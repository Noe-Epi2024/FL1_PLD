import 'dart:async';
import 'dart:math';
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
  final FutureOr<bool> Function(T)? onSelect;
  final Future<List<DropdownEntry<T>>> Function()? fetch;
  final bool isLazy;

  Future<void> _openList(BuildContext context) async {
    final DropdownProvider<T> provider = context.read<DropdownProvider<T>>()
      ..isOpen = true;

    await _pushList(context);

    provider.isOpen = false;
  }

  Future<void> _onClick(BuildContext context) async {
    final DropdownProvider<T> provider = context.read<DropdownProvider<T>>();

    if (provider.isInitialized) {
      unawaited(_openList(context));
    } else {
      try {
        provider.isLoading = true;

        unawaited(_openList(context));

        final List<DropdownEntry<T>> fetchedEntries = await fetch!();

        provider.setSuccessState(fetchedEntries);
      } on ErrorModel catch (e) {
        provider.setErrorState(e);
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

  Widget _button(BuildContext context) {
    final String? selectedValue = context.select<DropdownProvider<T>, String?>(
      (DropdownProvider<T> provider) => provider.selectedValue?.key,
    );

    final bool isOpen = context.select<DropdownProvider<T>, bool>(
      (DropdownProvider<T> provider) => provider.isOpen,
    );

    return Builder(
      builder: (BuildContext builderContext) => InkWell(
        onTap: () async => _onClick(builderContext),
        child: InputDecorator(
          isFocused: isOpen,
          isEmpty: selectedValue == null,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            labelText: labelText,
            prefixIcon: const Icon(Icons.person),
            suffixIcon: isOpen
                ? const Icon(Icons.arrow_drop_up_rounded)
                : const Icon(Icons.arrow_drop_down_rounded),
          ),
          child: selectedValue != null ? Text(selectedValue) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DropdownProvider<T>>(
        create: (_) => isLazy
            ? DropdownProvider<T>.lazy(initialValue: initialValue)
            : DropdownProvider<T>(
                entries: entries!,
                initialValue: initialValue,
              ),
        builder: (BuildContext providerContext, _) => _button(providerContext),
      );
}
