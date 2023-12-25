class PictureModel {
  PictureModel({this.url});

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      PictureModel(url: json['url']);

  String? url;
}
