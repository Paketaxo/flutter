import 'package:base/common/theme/colors.dart';
import 'package:base/common/theme/styles.dart';
import 'package:base/common/utils/ui_helpers.dart';
import 'package:base/common/widgets/custom_text.dart';
import 'package:base/common/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home.vs.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool menu = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeVM>.reactive(
      viewModelBuilder: () => HomeVM(),
      onModelReady: (model) => model.getSharedPreferences(),
      builder: (context, model, child) => (model.isBusy)
          ? const Loading(backgroundColor: backgroundColor)
          : Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
              elevation: 5,
              backgroundColor: backgroundColor,
              leading: IconButton(
                onPressed: () => menu
                    ? {_scaffoldKey.currentState!.openDrawer()}
                    : Navigator.of(context).pop(),
                icon: const Icon(Icons.menu),
                color: menu ? kcPrimaryColor : Colors.black,
              ),
              title: Text(
                "App",
                style: headline5.copyWith(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              ),
              drawer: _buildDrawer(model, context),
              body: Center(
                child: CustomText.headline1("Bienvenido"),
              ),
            ),
    );
  }

  _buildDrawer(HomeVM model, BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildUserAccountSide(context, model),
          // _buildUserMenus(context, model),
          _buildCloseSesionButton(model)
        ],
      ),
    );
  }

  _buildUserAccountSide(BuildContext context, HomeVM model) {
    return Stack(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Color.fromRGBO(238, 235, 230, 1.0)),
          child:  Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                    ),
                    child: const Icon(Icons.person),
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomText.caption("")
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }

  _buildUserMenus(BuildContext context, HomeVM model) {
    return const SizedBox();
  }

  _buildCloseSesionButton(HomeVM model) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10),
      leading: const Icon(Icons.close),
      title: CustomText.bodyText1('Cerrar sesión'),
      onTap: () async => model.navigateToLoginAfterLogOut(),
    );
  }
}
