import 'package:base/app/presentation/login/login_vm.dart';
import 'package:base/common/theme/styles.dart';
import 'package:base/common/utils/constants.dart';
import 'package:base/common/utils/ui_helpers.dart';
import 'package:base/common/widgets/box_button.dart';
import 'package:base/common/widgets/custom_link.dart';
import 'package:base/common/widgets/custom_text.dart';
import 'package:base/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscure = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(
      viewModelBuilder: () => LoginVM(),
      onModelReady: (model) async => await model.iniciar(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: _buildBody(model),
      ),
    );
  }

  SingleChildScrollView _buildBody(LoginVM model) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(logoPath),
              const FlutterLogo(),
              const SizedBox(
                height: 40,
              ),
              _buildLogInTextFields(model),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogInTextFields(LoginVM model) {
    return ReactiveForm(
      formGroup: model.form,
      child: Column(
        children: [
          // _buildUsername(),
          CustomTextField.email(
              readOnly: model.isBusy,
              labelText: "Usuario/Correo Electrónico",
              formControlName: cEmail),
          const SizedBox(
            height: 20,
          ),
          CustomTextField.password(
              readOnly: model.isBusy,
              labelText: "Contraseña",
              formControlName: cPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: _isObscure ? Colors.grey : null,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              obscureText: _isObscure),
          const SizedBox(
            height: 20,
          ),
          _buildForgottenPassword(model),
          const SizedBox(
            height: 20,
          ),
          _buildLoginButton(model),
        ],
      ),
    );
  }

  Widget _buildLoginButton(LoginVM model) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return BoxButton(
          width: double.infinity,
          busy: model.isBusy,
          disabled: !form.valid,
          onTap: () async {
            // print(form.valid);
            if (form.valid) {
              await model.signIn();
              if (model.login is String) {
                showDialog(
                  context: context,
                  builder: (_) => BackdropFilter(
                    filter: UIHelper.blur,
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(15.0),
                      insetPadding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.maybePop(context),
                          child: const Text("Aceptar"),
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.resolveWith(
                              (states) =>
                                  headline2.copyWith(color: Colors.blue),
                            ),
                          ),
                        )
                      ],
                      content: FittedBox(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                size: 80,
                                color: Colors.red,
                              ),
                              const Spacer(),
                              SizedBox(
                                child: CustomText.headline1(
                                  model.errorMsg +
                                      ", asegúrate de ingresarlos correctamente",
                                  align: TextAlign.center,
                                  multiline: true,
                                  maxLines: 3,
                                ),
                                height: 120,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else {
              model.form.markAsDirty();
              model.form.control(cEmail).markAsDirty();
              model.form.control(cEmail).markAsTouched();
              model.form.control(cPassword).markAsDirty();
              model.form.control(cPassword).markAsTouched();
            }
          },
          title: "Iniciar sesión",
        );
      },
    );
  }

  Widget _buildForgottenPassword(LoginVM model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText.caption("¿Olvidaste tu contraseña?"),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: CustomLink.caption(text: "Recuperar"),
          onTap: () => model.navigateToRecuperar(),
        )
      ],
    );
  }
}
