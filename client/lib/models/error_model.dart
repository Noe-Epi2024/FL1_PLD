class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromJson(json) =>
      ErrorModel(errorMessage: json["message"]);
}
