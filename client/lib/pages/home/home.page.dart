import "package:flutter/material.dart";

import "../../components/future_widget/future_widget.dart";
import "../../http/requests/projects/projects_requests.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureWidget(
          future: GetProjects().get,
          widget: (projects) => ListView(
            children: projects.projects.map((e) => Text(e.name)).toList(),
          ),
        ),
      );
}
