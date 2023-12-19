class ErrorModel {
  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(errorMessage: json['message']);
  final String errorMessage;
}
