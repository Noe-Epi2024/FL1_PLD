import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/user/me_model.dart';

class ProfileProvider extends ProviderBase {
  ProfileProvider() : super(isInitiallyLoading: true);

  MeModel? _me;

  MeModel? get me => _me;

  set me(MeModel? value) {
    _me = value;
    notifyListeners();
  }

  String? _currentName;

  String? get currentName => _currentName;

  set currentName(String? value) {
    _currentName = value;
    notifyListeners();
  }

  String? _currentEmail;

  String? get currentEmail => _currentEmail;

  set currentEmail(String? value) {
    _currentEmail = value;
    notifyListeners();
  }

  void setSuccessState(MeModel value) {
    _me = value;
    isLoading_ = false;
    notifyListeners();
  }

  void setName(String name) {
    _me?.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _me?.email = email;
    notifyListeners();
  }
}
