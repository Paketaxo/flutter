import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends StatefulWidget {
  final String labelText, formControlName;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool decoration;
  bool readOnly = false;
  int? maxL;
  int? minL;
  List<TextInputFormatter>? formatters = [];
  Map<String, String> Function(FormControl<dynamic>)? funcion =
      (FormControl control) {
    return {};
  };
  TextCapitalization? textCapitalization = TextCapitalization.none;
  TextInputType keyboard = TextInputType.name;
  bool Function()? formatter;

  CustomTextField(
      {Key? key,
      required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.maxL,
      this.formatter,
      this.decoration = true,
      this.keyboard = TextInputType.text})
      : super(key: key) {
    funcion = (control) => {
          'required': 'Campo requerido',
        };
  }

  CustomTextField.name(
      {Key? key, required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.formatter,
      this.decoration = true}) : super(key: key) {
    formatters!.add(
      FilteringTextInputFormatter.deny(
        RegExp(r'^\s|\s{2,}|\s$/'),
      ),
    );
    formatters!.add(CapitalEachWord());
    formatters!.add(
      FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z\sÁÉÍÓÚáéíóú]"),
      ),
    );
    funcion = (control) => {
          'required': 'Campo requerido',
        };
    textCapitalization = TextCapitalization.words;
  }

  CustomTextField.number(
      {Key? key, required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.formatters,
      this.formatter,
      this.decoration = true,
      this.minL,
      this.maxL}) : super(key: key) {
    formatters!.add(
      FilteringTextInputFormatter.allow(
        RegExp(r"[0-9]"),
      ),
    );
    formatters!.add(
      FilteringTextInputFormatter.deny(
        RegExp(r"[a-zA-Z\s]"),
      ),
    );
    funcion = (control) => {
          'required': 'Campo requerido',
          'minLength': 'Mínimo $minL caracteres',
          'maxLength': 'Máximo $minL caracteres'
        };
    keyboard = TextInputType.number;
  }

  CustomTextField.phoneNumber(
      {Key? key, required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.formatters,
      this.formatter,
      this.decoration = true,
      this.minL,
      this.maxL}) : super(key: key) {
    funcion = (control) => {
          'required': 'Campo requerido',
          'minLength': 'Mínimo $minL caracteres',
          'maxLength': 'Máximo $minL caracteres'
        };
    keyboard = TextInputType.number;
  }

  CustomTextField.email(
      {Key? key, required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.formatter,
      this.decoration = true,
      this.keyboard = TextInputType.emailAddress}) : super(key: key) {
    formatters!.add(
      FilteringTextInputFormatter.deny(
        RegExp(r'\s'),
      ),
    );
    funcion = (control) => {
          'required': 'Campo requerido',
          'email': 'Correo inválido',
          'mustMatch': 'Los correos deben coincidir'
        };
  }

  CustomTextField.password(
      {Key? key, required this.labelText,
      required this.formControlName,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.maxL = 16,
      this.minL = 8,
      this.formatter,
      this.decoration = true,
      this.keyboard = TextInputType.text}) : super(key: key) {
    formatters!.add(
      FilteringTextInputFormatter.deny(
        RegExp(r'\s'),
      ),
    );
    funcion = (control) => {
          'required': 'Campo requerido',
          'pattern': 'Mínimo 1 letra, un número y un símbolo',
          'minLength': 'Mínimo 8 caracteres',
          'maxLength': 'Máximo 10 caracteres'
        };
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  get headline3 => null;

  @override
  Widget build(BuildContext context) {
    var formatters = widget.formatters;

    final decoration = InputDecoration(
      border: const UnderlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: Colors.grey),
      ),
      labelStyle: headline3,
      labelText: widget.labelText,
      suffixIcon: widget.suffixIcon,
    );

    return ReactiveTextField(
      readOnly: widget.readOnly,
      showErrors: (control) =>
          control.invalid && control.touched && control.dirty,
      textInputAction: TextInputAction.next,
      inputFormatters: formatters ?? [],
      keyboardType: widget.keyboard,
      textCapitalization: widget.textCapitalization!,
      maxLength: widget.maxL,
      style: headline3,
      decoration: decoration,
      validationMessages: widget.funcion,
      formControlName: widget.formControlName,
      obscureText: widget.obscureText,
    );
  }
}

class CapitalEachWord extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newString = newValue.text.replaceAllMapped(
        RegExp(r'^[a-z]|\s[a-z]'), (match) => match[0]!.toUpperCase());
    return newValue.copyWith(text: newString);
  }
}
