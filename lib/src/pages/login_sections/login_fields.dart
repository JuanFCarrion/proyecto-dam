import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/providers/welcome_provider.dart';
import 'package:proyecto_dam/src/services/auth_service.dart';
import 'package:proyecto_dam/src/utils/regex.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final validateLogin = Provider.of<ValidateLoginProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Form(
        key: validateLogin.formKey,
        child: Column(
          children: [
            field(
              initial: 'nombre@email.es',
              inputType: TextInputType.emailAddress,
              validator: matchEmail,
              onChanged: (value) => validateLogin.email = value,
              decoration: fieldsDecoration(
                labelText: 'Usuario',
                hintText: 'nombre@email.es',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 20),
            field(
              initial: '12345678',
              inputType: TextInputType.text,
              validator: matchPassword,
              onChanged: (value) => validateLogin.password = value,
              nextInput: false,
              obscureText: _obscureText,
              decoration: fieldsDecoration(
                labelText: 'Contraseña',
                hintText: '12345678A',
                icon: Icons.lock,
              ).copyWith(
                suffixIcon: InkWell(
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onTap: () => setState(() {
                    _obscureText = !_obscureText;
                  }),
                ),
              ),
            ),
            const SizedBox(height: 40),
            button(
              title: validateLogin.isLoading ? 'ENVIANDO...' : 'ENTRAR',
              onPressed: _validation(validateLogin, context),
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

            final auth = Provider.of<AuthService>(context, listen: false);

            final String? errorMessage = await auth.loginUser(
              provider.email,
              provider.password,
            );

            // || provider.email == ''
            if (errorMessage == null) {
              provider.isValidate = true;

              return showDialog(
                context: context,
                builder: (_) {
                  Future.delayed(
                    const Duration(milliseconds: 400),
                    () => Navigator.of(context)
                        .pushNamedAndRemoveUntil('resume', (route) => false),
                  );

                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      content: text('Datos correctos', centered: true),
                    ),
                  );
                },
              );
            } else {
              return showDialog(
                context: context,
                builder: (_) {
                  Future.delayed(
                    const Duration(milliseconds: 750),
                    () => Navigator.of(context).pop(),
                  ).then((_) => provider.isLoading = false);
                  return AlertDialog(
                      content: text('Datos incorrectos', centered: true));
                },
              );
            }
          };
  }
}
