part of '../project_page.dart';

class _ProjectPageContent extends StatelessWidget {
  const _ProjectPageContent();

  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 2,
        child: TabBarView(
          children: <Widget>[
            ProjectTasksTab(),
            ProjectMembersTab(),
          ],
        ),
      );
}
