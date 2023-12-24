class SubtaskModel {
  SubtaskModel({required this.id, required this.name, required this.isDone});

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      SubtaskModel(id: json['_id'], name: json['name'], isDone: json['isDone']);

  final String id;
  String name;
  bool isDone;
}
