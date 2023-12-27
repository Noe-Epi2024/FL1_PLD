part of 'dropdown.dart';

class _DropdownList<T> extends HookWidget {
  const _DropdownList({required this.onSelect, super.key});

  final FutureOr<bool> Function(T)? onSelect;

  void _onSearchChanged(BuildContext context, String filter) {
    context.read<DropdownProvider<T>>().filter = filter;
  }

  Widget _choices(BuildContext context) {
    final List<DropdownEntry<T>> entries =
        context.select<DropdownProvider<T>, List<DropdownEntry<T>>>(
      (DropdownProvider<T> provider) => provider.entries!,
    );

    final String? filter = context.select<DropdownProvider<T>, String?>(
      (DropdownProvider<T> p) => p.filter,
    );

    final List<_DropdownItem<T>> items = (filter == null
            ? entries
            : entries.where(
                (DropdownEntry<T> entry) =>
                    entry.key.toLowerCase().contains(filter.toLowerCase()),
              ))
        .map(
          (DropdownEntry<T> entry) => _DropdownItem<T>(
            entry: entry,
            onSelect: onSelect,
          ),
        )
        .toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListView(children: items),
    );
  }

  Widget _searchBar(TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Filtrer',
            prefixIcon: TextFieldIcon(FontAwesomeIcons.magnifyingGlass),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      controller
          .onValueChanged((String value) => _onSearchChanged(context, value)),
    );

    return Card(
      color: Theme.of(context).colorScheme.background,
      elevation: 3,
      child: ProviderResolver<DropdownProvider<T>>(
        builder: (BuildContext resolverContext) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _searchBar(controller),
            Expanded(child: _choices(resolverContext)),
          ],
        ),
      ),
    );
  }
}

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
