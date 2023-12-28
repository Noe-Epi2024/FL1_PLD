import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/components/dropdown/dropdown_provider.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:provider/provider.dart';

part 'dropdown_list.dart';
part 'dropdown_item.dart';
part 'dropdown_route.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    required this.entries,
    super.key,
    this.onSelect,
    this.initialValue,
    this.labelText,
    this.readonly = false,
  })  : isLazy = false,
        fetch = null;

  const Dropdown.lazy({
    required this.fetch,
    super.key,
    this.onSelect,
    this.initialValue,
    this.labelText,
    this.readonly = false,
  })  : isLazy = true,
        entries = null;

  final List<DropdownEntry<T>>? entries;
  final DropdownEntry<T>? initialValue;
  final String? labelText;
  final FutureOr<bool> Function(T)? onSelect;
  final Future<List<DropdownEntry<T>>> Function()? fetch;
  final bool isLazy;
  final bool readonly;

  Future<void> _openList(BuildContext context) async {
    final DropdownProvider<T> provider = context.read<DropdownProvider<T>>()
      ..isOpen = true;

    await _pushList(context);

    if (!context.mounted) return;

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

        if (!context.mounted) return;

        provider.setSuccessState(fetchedEntries);
      } on ErrorModel catch (e) {
        if (!context.mounted) return;

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

    return InkWell(
      onTap: readonly ? null : () async => _onClick(context),
      child: InputDecorator(
        isFocused: isOpen,
        isEmpty: selectedValue == null,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelText: labelText,
          prefixIcon: const TextFieldIcon(FontAwesomeIcons.solidUser),
          suffixIcon: isOpen
              ? const TextFieldIcon(FontAwesomeIcons.angleUp)
              : const TextFieldIcon(FontAwesomeIcons.angleDown),
        ),
        child: selectedValue != null ? Text(selectedValue) : null,
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
