import 'package:base/common/app.locator.dart';
import 'package:base/common/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  late SharedPreferences prefs;

  void getSharedPreferences() async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();
    setBusy(false);
  }

  navigateToLoginAfterLogOut() async {
    prefs.clear();
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
