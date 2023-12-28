import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/date_picker/date_picker_provider.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/helpers/date_helper.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    required this.onSelected,
    super.key,
    this.label,
    this.initialDate,
    this.readonly = false,
  });

  final FutureOr<bool> Function(DateTime date) onSelected;
  final String? label;
  final DateTime? initialDate;
  final bool readonly;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DatePickerProvider>(
        create: (_) => DatePickerProvider(initialDate: initialDate),
        child: _DatePickerBuilder(
          onSelected: onSelected,
          label: label,
          readonly: readonly,
        ),
      );
}

class _DatePickerBuilder extends StatelessWidget {
  const _DatePickerBuilder({
    required this.onSelected,
    this.label,
    this.readonly = false,
  });

  final FutureOr<bool> Function(DateTime date) onSelected;
  final String? label;
  final bool readonly;

  Future<void> _onClick(BuildContext context) async {
    final DatePickerProvider provider = context.read<DatePickerProvider>();

    final DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 1000)),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
      initialDate: provider.date ?? DateTime.now(),
    );

    if (newDate != null &&
        newDate != provider.date &&
        await onSelected(newDate)) provider.date = newDate;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? selectedDate =
        context.select<DatePickerProvider, DateTime?>(
      (DatePickerProvider provider) => provider.date,
    );

    final bool isOpen = context.select<DatePickerProvider, bool>(
      (DatePickerProvider provider) => provider.isOpen,
    );

    return InkWell(
      onTap: readonly ? null : () async => _onClick(context),
      child: InputDecorator(
        isFocused: isOpen,
        isEmpty: selectedDate == null,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: label,
          prefixIcon: const TextFieldIcon(FontAwesomeIcons.calendarDays),
        ),
        child: selectedDate != null
            ? Text(DateHelper.formatDateToFrench(selectedDate))
            : null,
      ),
    );
  }
}
