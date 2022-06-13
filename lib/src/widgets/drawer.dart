import 'dart:ui';

import 'package:proyecto_dam/src/providers/prefix_provider.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/services/auth_service.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';
import 'package:proyecto_dam/src/constants/texts.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    // final prefixProvider = Provider.of<PrefixProvider>(context);

    return ClipPath(
      clipper: _OvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  Image.asset(
                    drawer,
                    height: 210,
                    fit: BoxFit.fill,
                    colorBlendMode: BlendMode.darken,
                    color: black.withOpacity(0.7),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 0),
                    child: Container(
                      color: white.withOpacity(1),
                    ),
                  ),
                  /*Positioned(
                    top: 30,
                    left: 62,
                    child: Image.asset(
                      'assets/img/drawer_photo.png',
                      scale: 1.3,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),*/
                  Positioned(
                    left: 12,
                    bottom: 15,
                    child: text(
                      welcomeText,
                      color: greyMainBackground,
                      size: 14,
                      isLongText: true,
                    ),
                  )
                ],
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.home),
                title: text(startTitle, size: size16),
                onTap: () => Navigator.popAndPushNamed(context, 'resume'),
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.insert_chart_outlined),
                title: text(consumeTitle, size: size16),
                onTap: () => Navigator.popAndPushNamed(context, 'consume'),
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.description_outlined),
                title: text(invoicesTitle, size: size16),
                onTap: () => Navigator.popAndPushNamed(context, 'invoices'),
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.room),
                title: text(officeTitle, size: size16),
                onTap: () => Navigator.popAndPushNamed(context, 'offices'),
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.settings),
                title: text(configurationTitle, size: size16),
                onTap: () => Navigator.popAndPushNamed(context, 'settings'),
              ),
              ListTile(
                minLeadingWidth: 12,
                leading: const Icon(Icons.power_settings_new),
                title: text(closeSesionTitle, size: size16),
                onTap: () {
                  authService.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      loggin, (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                minLeadingWidth: 12,
                contentPadding: const EdgeInsets.only(right: 40, bottom: 25),
                title: Image.asset(drawerHelp, height: 240),
                onTap: help(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  help(context) {
    // PrefixProvider prefixProvider = Provider.of<PrefixProvider>(context);
    // Map<String, String> prefijos = prefixProvider.prefijos;

    // Map<String, String> prefijos = {
    //   'España': '+34',
    //   'Francia': '+35',
    //   'Portugal': '+36',
    // };

    return () {
      showDialog(
        context: context!,
        builder: (_) => AlertDialog(
          title: text(
            callU,
            bold: true,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              text(
                giveNumber,
                maxLine: 2,
                size: 14,
              ),
              const SizedBox(height: 10),
              const MenuPaises(),
              const SizedBox(height: 10),
              const _CampoTelf(),
              const SizedBox(height: 20),
              button(
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (_) {
                      Future.delayed(
                        const Duration(milliseconds: 1750),
                        () => Navigator.of(context).pop(),
                      ).whenComplete(() => Navigator.of(context).pop());
                      return AlertDialog(
                          content: text(
                        waitCall,
                        centered: true,
                        maxLine: 2,
                      ));
                    },
                  );
                },
                title: callTitle,
              ),
            ],
          ),
        ),
      );
    };
  }
}

class _CampoTelf extends StatefulWidget {
  const _CampoTelf({
    Key? key,
  }) : super(key: key);

  @override
  __CampoTelfState createState() => __CampoTelfState();
}

class __CampoTelfState extends State<_CampoTelf> {
  @override
  Widget build(BuildContext context) {
    PrefixProvider prefixProvider = Provider.of<PrefixProvider>(context);
    var prefijos = prefixProvider.prefijos;

    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: defectNumberPhone,
      decoration:
          InputDecoration(prefix: text(prefijos[prefixProvider.pais])), //
    );
  }
}

class MenuPaises extends StatefulWidget {
  const MenuPaises({Key? key}) : super(key: key);

  @override
  _MenuPaisesState createState() => _MenuPaisesState();
}

class _MenuPaisesState extends State<MenuPaises> {
  String dropdownValue = '';

  // String dropdownValue = Provider.of<PrefixProvider>(context).pais;

  @override
  Widget build(BuildContext context) {
    PrefixProvider prefixProvider = Provider.of<PrefixProvider>(context);
    dropdownValue = prefixProvider.pais;
    print(prefixProvider.pais);
    // final prefixProvider = Provider.of<PrefixProvider>(context);
    return DropdownButton(
        value: prefixProvider.pais,
        onChanged: (String? newValue) {
          setState(() {
            prefixProvider.pais = newValue!;
          });
        },
        items: [spain, portugal, france, germany]
            .map((e) => DropdownMenuItem(
                  child: text(e),
                  value: e,
                ))
            .toList());
  }
}

class _OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
      size.width,
      size.height / 4,
      size.width,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width,
      size.height - (size.height / 4),
      size.width - 50,
      size.height,
    );
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
