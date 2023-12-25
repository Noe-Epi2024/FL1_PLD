class SubtaskModel {
  SubtaskModel({required this.id, this.name, this.isDone = false});

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      SubtaskModel(id: json['_id'], name: json['name'], isDone: json['isDone']);

  final String id;
  String? name;
  bool isDone;
}
