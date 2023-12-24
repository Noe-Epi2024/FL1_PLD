class TaskPreviewModel {
  TaskPreviewModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.startDate,
    required this.endDate,
    this.progress,
  });

  factory TaskPreviewModel.fromJson(Map<String, dynamic> json) =>
      TaskPreviewModel(
        id: json['id'],
        name: json['name'],
        ownerName: json['ownerName'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        progress: json['progress'],
      );

  final String id;
  String name;
  String ownerName;
  DateTime startDate;
  DateTime endDate;
  int? progress;
}
