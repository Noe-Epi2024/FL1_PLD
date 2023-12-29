import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/app/app_layout_desktop.dart';
import 'package:hyper_tools/pages/project/project_page_mobile.dart';

class ProjectPageDesktop extends StatelessWidget {
  const ProjectPageDesktop({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: AppLayoutDesktop(child: ProjectPageMobile()),
      );
}
