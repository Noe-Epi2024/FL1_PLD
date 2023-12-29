part of '../../profile_page.dart';

class _ProfilePageMobile extends StatelessWidget {
  const _ProfilePageMobile();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const _ProfilePageContent(),
      );
}
