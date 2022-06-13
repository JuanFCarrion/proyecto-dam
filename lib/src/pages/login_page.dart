import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/providers/welcome_provider.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

import 'login_sections/login_fields.dart';
import 'login_sections/signup_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValidateLoginProvider()),
        ChangeNotifierProvider(create: (_) => ValidateSignupProvider()),
        ChangeNotifierProvider(create: (_) => WelcomeFormProvider()),
      ],
      child: Scaffold(
        body: SafeArea(
          minimum: (screen.width > 500)
              ? EdgeInsets.symmetric(horizontal: screen.width * 0.1)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                _Logo(),
                _ListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(height: screen.height * 0.2),
        Column(
          children: [
            Container(
              height: screen.height * 0.03,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    greyMainBackground.withOpacity(0.1),
                    greyMainBackground.withOpacity(1),
                  ],
                ),
              ),
            ),
            Container(
              color: greyMainBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SelectForm(),
                  _ShowForm(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Logo extends StatefulWidget {
  @override
  __LogoState createState() => __LogoState();
}

class __LogoState extends State<_Logo> {
  @override
  Widget build(BuildContext context) {
    final validateSignup = Provider.of<ValidateLoginProvider>(context);
    bool startTransition = validateSignup.isValidate;
    return AnimatedCrossFade(
      sizeCurve: Curves.easeInOutQuint,
      duration: const Duration(milliseconds: 2000),
      crossFadeState: (startTransition)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: AppBar(
        backgroundColor: greyMainBackground,
        toolbarHeight: 220,
        title: Image.asset(
          logo,
          scale: 0.8,
          fit: BoxFit.contain,
        ),
      ),
      secondChild: AppBar(
        toolbarHeight: null,
        title: Image.asset(
          logo,
          scale: null,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _SelectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<WelcomeFormProvider>(context);
    final form = formProvider.selectedForm;

    final width = MediaQuery.of(context).size.width;
    final _styleRadius = ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );

    return Flex(
      direction: width > 310 ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: text(
            ' Iniciar Sesión ',
            size: 18,
            color: form == 0 ? redLetter : greyLetter,
          ),
          style: _styleRadius,
          onPressed: () => formProvider.selectedForm = 0,
        ),
        TextButton(
          child: text(
            ' Solicitar Acceso ',
            size: 18,
            color: form == 1 ? redLetter : greyLetter,
          ),
          style: _styleRadius,
          onPressed: () => formProvider.selectedForm = 1,
        ),
      ],
    );
  }
}

class _ShowForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final form = Provider.of<WelcomeFormProvider>(context).selectedForm;

    switch (form) {
      case 0:
        return const LoginFields();
      case 1:
        return const SignUpFields();
      default:
        return const LoginFields();
    }
  }
}
