import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/providers/welcome_provider.dart';
import 'package:proyecto_dam/src/services/auth_service.dart';
import 'package:proyecto_dam/src/utils/regex.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class SignUpFields extends StatelessWidget {
  const SignUpFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validateSignup = Provider.of<ValidateSignupProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Form(
        key: validateSignup.formKey,
        child: Column(
          children: [
            field(
              inputType: TextInputType.text,
              validator: matchDni,
              onChanged: (value) => validateSignup.password = value,
              decoration: fieldsDecoration(
                icon: Icons.person,
                labelText: 'DNI / CIF',
                hintText: 'Sin guiones ni espacios',
              ),
            ),
            const SizedBox(height: 20),
            field(
              inputType: TextInputType.emailAddress,
              validator: matchEmail,
              onChanged: (value) => validateSignup.email = value,
              decoration: fieldsDecoration(
                labelText: 'Correo electrónico',
                icon: Icons.alternate_email,
              ),
            ),
            const SizedBox(height: 20),
            field(
              inputType: TextInputType.number,
              validator: matchAccount,
              onChanged: (value) => validateSignup.account = value,
              decoration: fieldsDecoration(
                labelText: 'Domiciliación bancaria',
                hintText: 'Introduzca los 4 últimos digitos de su cuenta',
                icon: Icons.credit_card,
              ),
            ),
            const SizedBox(height: 20),
            field(
              inputType: TextInputType.number,
              validator: matchInvoice,
              onChanged: (value) => validateSignup.invoice = value,
              nextInput: false,
              decoration: fieldsDecoration(
                labelText: 'Importe factura',
                hintText: 'Importe de la última factura',
                icon: Icons.euro,
              ),
            ),
            const SizedBox(height: 40),
            button(
              title: 'SOLICITAR',
              onPressed: _validation(validateSignup, context),
            ),
          ],
        ),
      ),
    );
  }

  _validation(provider, context) {
    return provider.isLoading
        ? null
        : () async {
            provider.isLoading = true;
            FocusScope.of(context).unfocus();

            if (!provider.isValidForm()) return provider.isLoading = false;

            final auth = Provider.of<AuthService>(context, listen: false);

            final String? errorMessage = await auth.createUser(
              provider.email,
              provider.password,
            );

            if (errorMessage == null) {
              return showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(
                    const Duration(milliseconds: 1000),
                    () => Navigator.of(context).pop(),
                  )
                    ..then((_) => provider.clearForm())
                    ..then((_) => provider.isLoading = false);
                  return AlertDialog(
                      title: text('Datos enviados', centered: true));
                },
              );
            } else {
              print(errorMessage);
              return showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () => provider.isLoading = false,
                  ).then((_) => Navigator.of(context).pop());
                  return AlertDialog(
                      title: text('Datos incorrectos', centered: true));
                },
              );
            }
          };
  }
}
