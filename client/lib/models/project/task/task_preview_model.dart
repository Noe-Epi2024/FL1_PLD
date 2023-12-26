class TaskPreviewModel {
  TaskPreviewModel({
    required this.id,
    required this.numberOfSubtasks,
    required this.numberOfCompletedSubtasks,
    this.name,
    this.ownerName,
    this.startDate,
    this.endDate,
  });

  factory TaskPreviewModel.fromJson(Map<String, dynamic> json) =>
      TaskPreviewModel(
        id: json['id'],
        name: json['name'],
        ownerName: json['ownerName'],
        startDate: DateTime.tryParse(json['startDate'] ?? ''),
        endDate: DateTime.tryParse(json['endDate'] ?? ''),
        numberOfSubtasks: json['numberOfSubtasks'],
        numberOfCompletedSubtasks: json['numberOfCompletedSubtasks'],
      );

  final String id;
  String? name;
  String? ownerName;
  DateTime? startDate;
  DateTime? endDate;
  int numberOfSubtasks;
  int numberOfCompletedSubtasks;
}
