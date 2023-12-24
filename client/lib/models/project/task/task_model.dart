import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';

class TaskModel {
  TaskModel({
    required this.ownerName,
    required this.id,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.startDate,
    required this.endDate,
    required this.substasks,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        ownerId: json['ownerId'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        substasks: List<Map<String, dynamic>>.from(json['subtasks'])
            .map(SubtaskModel.fromJson)
            .toList(),
        ownerName: json['ownerName'],
      );

  final String id;
  String name;
  String description;
  String ownerId;
  String ownerName;
  DateTime startDate;
  DateTime endDate;
  List<SubtaskModel> substasks;
}
