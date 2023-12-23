part of 'dropdown.dart';

class _DropdownList<T> extends HookWidget {
  const _DropdownList({required this.onSelect, super.key});

  final void Function(T)? onSelect;

  ListView _choices(BuildContext context) => ListView(
        shrinkWrap: true,
        children: context
            .select<DropdownProvider<T>, List<DropdownEntry<T>>>(
              (DropdownProvider<T> provider) => provider.entries!,
            )
            .where(
              (DropdownEntry<T> entry) => entry.key
                  .contains(context.read<DropdownProvider<T>>().filter),
            )
            .map(
              (DropdownEntry<T> entry) => _DropdownItem<T>(
                entry: entry,
                onSelect: onSelect,
              ),
            )
            .toList(),
      );

  Widget _searchBar() => TextField(
        decoration: InputDecoration(
            hintText: 'Filtrer', prefixIcon: Icon(Icons.search)),
      );

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ProviderResolver<DropdownProvider<T>>(
            builder: (BuildContext resolverContext) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _searchBar(),
                Expanded(child: _choices(resolverContext)),
              ],
            ),
          ),
        ),
      );
}

class _DropdownItem<T> extends StatelessWidget {
  const _DropdownItem({
    required this.onSelect,
    required this.entry,
    super.key,
  });

  final void Function(T)? onSelect;
  final DropdownEntry<T> entry;

  @override
  Widget build(BuildContext context) =>
      InkWell(onTap: () => onSelect?.call(entry.value), child: Text(entry.key));
}
