
import 'package:base/app/presentation/recuperar_contrasena/recuperar_contrasena_vm.dart';
import 'package:base/common/utils/constants.dart';
import 'package:base/common/widgets/box_button.dart';
import 'package:base/common/widgets/custom_text.dart';
import 'package:base/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class RecuperarContrasenaView extends StatefulWidget {
  const RecuperarContrasenaView({Key? key}) : super(key: key);

  @override
  _RecuperarContrasenaViewState createState() =>
      _RecuperarContrasenaViewState();
}

class _RecuperarContrasenaViewState extends State<RecuperarContrasenaView> {
  TextEditingController emailC = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecuperarContrasenaViewModel>.reactive(
      viewModelBuilder: () => RecuperarContrasenaViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        // appBar: CustomAppBar.subHeader("Recuperación de Contraseña"),
        body: _buildBody(model),
      ),
    );
  }

  Widget _buildBody(RecuperarContrasenaViewModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(logoPath),
            const FlutterLogo(),
            const SizedBox(
              height: 40.0,
            ),
            _buildPassRecovery(model),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassRecovery(RecuperarContrasenaViewModel model) {
    return ReactiveForm(
      formGroup: model.form,
      child: Column(
        children: [
          CustomTextField.email(
              readOnly: model.isBusy,
              labelText: "Correo Electrónico",
              formControlName: cEmail),
          const SizedBox(
            height: 15.0,
          ),
          _buildRecoveryButton(model)
        ],
      ),
    );
  }

  Widget _buildRecoveryButton(RecuperarContrasenaViewModel model) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return BoxButton(
          width: double.infinity,
          busy: model.isBusy,
          disabled: !form.valid,
          title: "Enviar",
          onTap: () async {
            if (await model.recoverPassword(model.form.control(cEmail).value)) {
              const snackBar = SnackBar(
                  content: Text(
                    "Se mandó correo para el cambio de contraseña",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                  content: CustomText.errorSubtitle2(
                    "El correo ingresado es invalido",
                  ),
                  duration: const Duration(seconds: 2));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        );
      },
    );
  }
}
