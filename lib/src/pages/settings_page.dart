import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyecto_dam/src/config/theme.dart';
import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/providers/theme_provider.dart';
import 'package:proyecto_dam/src/widgets/drawer.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar:
          appBar(autoLeading: false, context: context, title: 'Configuración'),
      drawer: const MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Modo Oscuro"),
                Switch(
                  activeColor: red,
                  value: theme.getTheme() == AppThemeData.darkTheme,
                  onChanged: (value) {
                    value ? theme.setDarkMode() : theme.setLightMode();
                  },
                ),
              ],
            ),
            Center(
              widthFactor: 200,
              child: text(
                '''Aquí se pueden incluir configuraciones como:

· Modificación de datos de acceso.
· Solicitud de cambio de titular o datos bancarios.
· Modificación del domicilio.
· Bloqueo de línea por pérdida o robo.
· Bloqueo de llamadas internacionales, roaming o llamadas con tarificación especial.
· Configuración del buzón de voz.
· Configuración de llamada en espera y multillamada.
· Solicitud de duplicado de sim.
· Solicitud de factura a papel.
· Descargar contrato o solicitarlo.
· Aceptar o rechazar comunicaciones comerciales y por qué vías, cesión de datos y acceso a términos de uso, etc.
· Configuración de las notificaciones de la aplicación, como el aviso de uso de datos, ofertas y promociones o el aviso de factura disponible.
              ''',
                maxLine: 30,
                centered: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu),
      ),
    );
  }
}
