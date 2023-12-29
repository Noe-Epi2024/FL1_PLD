part of '../../project_page.dart';

class _ProjectPageDesktop extends StatelessWidget {
  const _ProjectPageDesktop();

  Widget _buildNavigationBar() => Builder(
        builder: (BuildContext context) => Card(
          margin: 16.horizontal,
          child: Padding(
            padding: 10.horizontal,
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
        ),
      );

  Card _buildAppBar() => Card(
        margin: 16.horizontal,
        child: const Row(
          children: <Widget>[
            Expanded(child: _ProjectName()),
            _ProjectPagePopupMenu(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => AppLayoutDesktop(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            16.height,
            const Expanded(child: _ProjectPageContent()),
            _buildNavigationBar(),
          ],
        ),
      );
}
