class SuccessModel {
  SuccessModel({
    this.data,
    this.message,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        data: json['data'],
        message: json['message'],
      );

  final dynamic data;
  final String? message;
}
