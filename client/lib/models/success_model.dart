class SuccessModel {
  final dynamic data;
  final String message;

  SuccessModel({
    required this.data,
    required this.message,
  });

  factory SuccessModel.fromJson(json) => SuccessModel(
        data: json["data"],
        message: json["message"],
      );
}
