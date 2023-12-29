part of '../../task_page.dart';

class _TaskPageDesktop extends StatelessWidget {
  const _TaskPageDesktop();

  @override
  Widget build(BuildContext context) => AppLayoutDesktop(
        child: Column(
          children: <Widget>[
            Card(margin: 16.horizontal, child: const _TaskName()),
            const Expanded(child: _TaskPageContent()),
          ],
        ),
      );
}
