part of '../../project_page.dart';

class _ProjectPageMobile extends StatelessWidget {
  const _ProjectPageMobile();

  AppBar _appBar(BuildContext context) => AppBar(
        title: const _ProjectName(),
        actions: const <Widget>[_ProjectPagePopupMenu()],
      );

  Widget _buildNavigationBar() => Builder(
        builder: (BuildContext context) => DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Tâches',
                icon: FaIcon(FontAwesomeIcons.listCheck, size: 16),
              ),
              Tab(
                text: 'Membres',
                icon: FaIcon(FontAwesomeIcons.userGroup, size: 16),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: _buildNavigationBar(),
        appBar: _appBar(context),
        body: const SafeArea(child: _ProjectPageContent()),
      );
}
