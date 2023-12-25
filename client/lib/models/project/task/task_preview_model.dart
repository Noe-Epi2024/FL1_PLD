class TaskPreviewModel {
  TaskPreviewModel({
    required this.id,
    this.name,
    this.ownerName,
    this.startDate,
    this.endDate,
    this.progress,
  });

  factory TaskPreviewModel.fromJson(Map<String, dynamic> json) =>
      TaskPreviewModel(
        id: json['id'],
        name: json['name'],
        ownerName: json['ownerName'],
        startDate: DateTime.tryParse(json['startDate'] ?? ''),
        endDate: DateTime.tryParse(json['endDate'] ?? ''),
        progress: json['progress'],
      );

  final String id;
  String? name;
  String? ownerName;
  DateTime? startDate;
  DateTime? endDate;
  int? progress;
}
