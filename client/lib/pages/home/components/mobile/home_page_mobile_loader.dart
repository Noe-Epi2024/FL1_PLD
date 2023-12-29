part of '../../home_page.dart';

class _HomePageMobileLoader extends StatelessWidget {
  const _HomePageMobileLoader();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
