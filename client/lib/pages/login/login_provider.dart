import 'package:hyper_tools/components/provider_base.dart';

class LoginProvider extends ProviderBase {
  bool _shouldStayLoggedIn = true;

  bool get shouldStayLoggedIn => _shouldStayLoggedIn;

  set shouldStayLoggedIn(bool value) {
    _shouldStayLoggedIn = value;
    notifyListeners();
  }
}
