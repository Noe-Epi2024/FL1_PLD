part of '../project_page.dart';

class _ProjectPageContent extends StatelessWidget {
  const _ProjectPageContent();

  @override
  Widget build(BuildContext context) => const TabBarView(
        children: <Widget>[
          ProjectTasksTab(),
          ProjectMembersTab(),
        ],
      );
}
