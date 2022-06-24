import 'package:base/app/services/user_service.dart';
import 'package:base/common/app.locator.dart';
import 'package:base/common/app.router.dart';
import 'package:base/common/utils/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  late SharedPreferences prefs;
  // bool login = true;
  late dynamic login = true;
  late String errorMsg;

  final form = FormGroup({
    cEmail: FormControl<String>(
      validators: [Validators.email, Validators.required],
    ),
    cPassword: FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(8),
      Validators.maxLength(16),
    ]),
  });

  Future<void> signIn() async {
    setBusy(true);
    notifyListeners();
    String email = form.control(cEmail).value;
    String password = form.control(cPassword).value;
    login = await _userService.signin(email, password);
    setBusy(false);
    if (login is bool && login) {
      navigateToHome();
    } else {
      errorMsg = login;
    }
  }

  iniciar() async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();

    // final currentLocation = await enableLocation();

    if (prefs.containsKey(kEmail)) {
      String email = prefs.getString(kEmail)!;
      String password = prefs.getString(kPassword)!;
      login = await _userService.signin(email, password);
      if (login) {
        navigateToHome();
      }
    }

    setBusy(false);
  }

  navigateToHome() {
    _navigationService.clearStackAndShow(Routes.homeNavigation);
  }

  navigateToRecuperar() {
    _navigationService.navigateTo(Routes.recuperarContrasenaView);
  }
}
