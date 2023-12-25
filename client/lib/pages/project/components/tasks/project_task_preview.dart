import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:hyper_tools/extensions/datetime_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/string_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_page.dart';
import 'package:hyper_tools/theme/theme.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class TaskPreview extends StatelessWidget {
  const TaskPreview(this.taskPreviewModel, {super.key});

  final TaskPreviewModel taskPreviewModel;

  Future<void> _onTapPreview(BuildContext context) async {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    await Navigation.push(
      MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
          ChangeNotifierProvider<ProjectProvider>.value(value: projectProvider),
        ],
        child: TaskPage(projectProvider.project!.id, taskPreviewModel.id),
      ),
    );
  }

  Widget _name() => Text(
        taskPreviewModel.name.or('Tâche sans nom'),
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _dates(BuildContext context) => Row(
        children: <Widget>[
          Icon(
            Boxicons.bx_calendar,
            size: 16,
            color: Theme.of(context).hintColor,
          ),
          8.width,
          Text(
            '${taskPreviewModel.startDate?.toFrench ?? "Indefini"} - ${taskPreviewModel.endDate?.toFrench ?? "Indefini"}',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ],
      );

  Text _assignedTo() =>
      Text('Assigné à ${taskPreviewModel.ownerName ?? "personne"}');

  Widget _progressBar(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(ThemeGenerator.kBorderRadius),
              minHeight: 10,
              value: taskPreviewModel.progress!.toDouble() / 100,
            ),
          ),
          16.width,
          Text(
            '${taskPreviewModel.progress}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _noSubtaskYet() => const Text('Pas encore de sous-tâche');

  @override
  Widget build(BuildContext context) => Card(
        margin: 4.vertical,
        child: InkWell(
          onTap: () async => _onTapPreview(context),
          child: Padding(
            padding: 16.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _name(),
                _dates(context),
                _assignedTo(),
                8.height,
                if (taskPreviewModel.progress != null)
                  _progressBar(context)
                else
                  _noSubtaskYet(),
              ],
            ),
          ),
        ),
      );
}
