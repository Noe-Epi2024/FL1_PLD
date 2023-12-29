part of '../../home_page.dart';

class _HomePageDesktop extends StatelessWidget {
  const _HomePageDesktop();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: const _CreateProjectButton(),
        body: AppLayoutDesktop(
          child: ProviderResolver<HomeProvider>(
            builder: (_) => const _HomePageContent(),
          ),
        ),
      );
}
