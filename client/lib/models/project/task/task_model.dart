import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerName,
    required this.startDate,
    required this.endDate,
    required this.substasks,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        ownerName: json['ownerName'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        substasks: List<Map<String, dynamic>>.from(json['subtasks'])
            .map(SubtaskModel.fromJson)
            .toList(),
      );

  final String id;
  final String name;
  final String description;
  final String ownerName;
  final DateTime startDate;
  final DateTime endDate;
  final List<SubtaskModel> substasks;
}
