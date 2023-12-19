import 'package:flutter/material.dart';
import 'package:hyper_tools/components/future_widget/future_widget.dart';
import 'package:hyper_tools/http/requests/projects/projects_requests.dart';
import 'package:hyper_tools/models/projects_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureWidget<ProjectsModel>(
          future: GetProjects().get,
          widget: (ProjectsModel projects) => ListView(
            children: projects.projects
                .map((ProjectPreviewModel e) => Text(e.name))
                .toList(),
          ),
        ),
      );
}
