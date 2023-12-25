import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/user/user_model.dart';
import 'package:hyper_tools/models/user/users_model.dart';

class AddProjectMemberModalProvider extends ProviderBase {
  String _filter = '';

  String get filter => _filter;

  set filter(String value) {
    _filter = value;
    notifyListeners();
  }

  UsersModel? _users;

  UsersModel? get users => _users;

  set users(UsersModel? value) {
    _users = value;
    notifyListeners();
  }

  UserModel findUser(String userId) =>
      _users!.users.firstWhere((UserModel user) => user.id == userId);

  void setSuccessState(UsersModel? value) {
    _users = value;
    isLoading_ = false;

    notifyListeners();
  }

  void deleteUser(String userId) {
    if (_users == null) return;

    _users!.users.removeWhere((UserModel user) => user.id == userId);

    notifyListeners();
  }
}
