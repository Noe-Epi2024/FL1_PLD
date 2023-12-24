import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/models/error_model.dart';

extension ShowError on ErrorModel {
  void show() => Messenger.showSnackBarError(errorMessage);
}
