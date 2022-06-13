import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:proyecto_dam/src/pages/pages.dart';
import 'package:proyecto_dam/src/services/auth_service.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class Slash extends StatefulWidget {
  const Slash({Key? key}) : super(key: key);

  @override
  SlashState createState() => SlashState();
}

class SlashState extends State<Slash> with AfterLayoutMixin<Slash> {
  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    bool _seen = prefs.getBool('seen') ?? false;

    if (_seen) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const CheckAuth(),
      ));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading();
  }
}

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FutureBuilder(
      future: authService.readToken(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) return Container();

        (snapshot.data == '')
            ? _toRoute(context, const LoginPage())
            : _toRoute(context, ResumePage());

        return _loading();
      },
    );
  }

  Future _toRoute(BuildContext context, Widget page) {
    return Future.microtask(() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    });
  }
}

Widget _loading() {
  return Scaffold(
    body: Center(child: text('Cargando...')),
  );
}
