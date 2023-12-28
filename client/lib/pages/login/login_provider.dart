import 'package:hyper_tools/components/provider/provider_base.dart';

class LoginProvider extends ProviderBase {
  bool _shouldStayLoggedIn = true;

  bool get shouldStayLoggedIn => _shouldStayLoggedIn;

  set shouldStayLoggedIn(bool value) {
    _shouldStayLoggedIn = value;
    notifyListeners();
  }

  String _email = '';

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }
}
