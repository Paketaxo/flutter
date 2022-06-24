import 'package:base/app/services/user_service.dart';
import 'package:base/common/app.locator.dart';
import 'package:base/common/utils/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class RecuperarContrasenaViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  final form = FormGroup({
    cEmail: FormControl<String>(
      validators: [Validators.email, Validators.required],
    ),
  });

  Future<bool> recoverPassword(String email) async {
    setBusy(true);
    notifyListeners();
    final a = await _userService.recoverPassword(email);
    setBusy(false);
    return a;
  }
}
