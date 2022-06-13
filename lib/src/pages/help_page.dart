import 'package:proyecto_dam/src/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/widgets/widgets.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(autoLeading: false, context: context, title: 'Ayuda'),
      drawer: const MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          widthFactor: 200,
          child: text(
            'En lugar de una página, saltaría un pop-up similar al de la web pero con los datos por defecto, con la opción de editarlos.',
            maxLine: 4,
            centered: true,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu),
      ),
    );
  }
}
