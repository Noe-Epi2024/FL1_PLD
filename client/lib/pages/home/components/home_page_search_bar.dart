part of '../home_page.dart';

class _HomePageSearchBar extends StatelessWidget {
  const _HomePageSearchBar();

  void _onSearchChanged(BuildContext context, String filter) {
    context.read<HomeProvider>().filter = filter;
  }

  @override
  Widget build(BuildContext context) => SearchBarField(
        hintText: 'Chercher un projet',
        onValueChanged: (String value) => _onSearchChanged(context, value),
      );
}
