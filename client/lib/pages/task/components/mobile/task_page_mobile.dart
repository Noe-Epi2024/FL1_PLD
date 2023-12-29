part of '../../task_page.dart';

class _TaskPageMobile extends StatelessWidget {
  const _TaskPageMobile();

  AppBar _buildAppBar() => AppBar(title: const _TaskName());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: const _TaskPageContent(),
      );
}
