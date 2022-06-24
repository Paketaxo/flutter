// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../app/presentation/home/home_v.dart';
import '../app/presentation/login/login_v.dart';
import '../app/presentation/recuperar_contrasena/recuperar_contrasena_v.dart';

class Routes {
  static const String loginView = '/';
  static const String homeNavigation = '/home-navigation';
  static const String recuperarContrasenaView = '/recuperar-contrasena-view';
  static const all = <String>{
    loginView,
    homeNavigation,
    recuperarContrasenaView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeNavigation, page: HomeNavigation),
    RouteDef(Routes.recuperarContrasenaView, page: RecuperarContrasenaView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    HomeNavigation: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeNavigation(),
        settings: data,
      );
    },
    RecuperarContrasenaView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RecuperarContrasenaView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}
