import 'package:base/app/presentation/home/home_v.dart';
import 'package:base/app/presentation/login/login_v.dart';
import 'package:base/app/presentation/recuperar_contrasena/recuperar_contrasena_v.dart';
import 'package:base/app/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  // MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: HomeNavigation, children: [ ]),
  MaterialRoute(page: RecuperarContrasenaView)
], dependencies: [
  // LazySingleton(classType: PlacesService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: UserService),
  // Singleton(classType: SharedPreferences)
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
