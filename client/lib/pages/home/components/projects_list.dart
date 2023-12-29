part of '../home_page.dart';

class _ProjectsList extends StatelessWidget {
  const _ProjectsList();

  @override
  Widget build(BuildContext context) {
    final HomeProvider provider = context.watch<HomeProvider>();

    final String filter = provider.filter;
    final List<ProjectPreviewModel> projectPreviews =
        provider.projects?.projects ?? <ProjectPreviewModel>[];

    if (projectPreviews.isEmpty) return const SizedBox.shrink();

    return Column(
      children: projectPreviews
          .where(
            (ProjectPreviewModel preview) =>
                preview.name.toLowerCase().contains(filter.toLowerCase()),
          )
          .map(ProjectPreview.new)
          .toList(),
    );
  }
}
