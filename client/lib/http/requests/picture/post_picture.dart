import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/multipart_request.dart';
import 'package:hyper_tools/models/picture/picture_model.dart';

class PostPicture extends MultipartRequest<PictureModel> {
  PostPicture({required super.filePath});

  @override
  PictureModel builder(Map<String, dynamic> json) =>
      PictureModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('picture');
}
