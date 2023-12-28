import 'package:flutter/material.dart';
import 'package:hyper_tools/components/provider/provider_base.dart';
import 'package:hyper_tools/models/user/me_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ProviderBase {
  ProfileProvider(this.context) : super(isInitiallyLoading: true);

  final BuildContext context;

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
    if (_me == null) return;

    _me?.name = name;
    context.read<HomeProvider>().setUserName(name);

    notifyListeners();
  }

  void setEmail(String email) {
    if (_me == null) return;

    _me?.email = email;

    notifyListeners();
  }
}
