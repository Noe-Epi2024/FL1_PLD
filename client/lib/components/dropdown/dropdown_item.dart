part of 'dropdown.dart';

class _DropdownItem<T> extends StatelessWidget {
  const _DropdownItem({
    required this.onSelect,
    required this.entry,
    super.key,
  });

  final FutureOr<bool> Function(T)? onSelect;
  final DropdownEntry<T> entry;

  Future<void> _onTap(BuildContext context) async {
    final DropdownProvider<T> provider = context.read<DropdownProvider<T>>();

    Navigation.pop();

    if (onSelect != null && await onSelect!(entry.value)) {
      provider.selectedValue = entry;
    }
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async => _onTap(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(entry.key),
          ),
        ),
      );
}
