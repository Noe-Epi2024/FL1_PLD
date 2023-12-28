import 'package:hyper_tools/components/provider/provider_base.dart';
import 'package:hyper_tools/models/picture/picture_model.dart';

class ProfilePictureProvider extends ProviderBase {
  ProfilePictureProvider() : super(isInitiallyLoading: true);

  PictureModel? _picture;

  PictureModel? get picture => _picture;

  set picture(PictureModel? value) {
    _picture = value;
    notifyListeners();
  }

  void setSuccessState(PictureModel value) {
    _picture = value;
    isLoading_ = false;
    notifyListeners();
  }
}
