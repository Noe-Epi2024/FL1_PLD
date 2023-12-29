part of '../../home_page.dart';

class _HomePageDesktop extends StatelessWidget {
  const _HomePageDesktop();

  @override
  Widget build(BuildContext context) => AppLayoutDesktop(
        child: Scaffold(
          floatingActionButton: const _CreateProjectButton(),
          body: ProviderResolver<HomeProvider>(
            builder: (_) => const _HomePageContent(),
          ),
        ),
      );
}
