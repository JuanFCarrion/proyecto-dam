import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/widgets/drawer.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class ConsumePage extends StatelessWidget {
  const ConsumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map> consume = [
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '15/08/2021 - 1:18',
        'valor': '33 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '15/08/2021 - 0:00',
        'valor': '5 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '14/08/2021 - 20:54',
        'valor': '9 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '14/08/2021 - 14:54',
        'valor': '12 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '14/08/2021 - 10:18',
        'valor': '3 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '14/08/2021 - 8:18',
        'valor': '16 MB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '14/08/2021 - 0:00',
        'valor': '14 MB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 23:41',
        'valor': '1 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Llamada',
        'fecha': '13/08/2021 - 20:52',
        'valor': '00:00:14',
        'precio': '0,00 €',
        'telf': '651 424 586',
      },
      <String, String>{
        'tipo': 'Llamada',
        'fecha': '13/08/2021 - 20:46',
        'valor': '00:00:13',
        'precio': '0,00 €',
        'telf': '671 634 824',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 17:41',
        'valor': '13 MB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 13:23',
        'valor': '9 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 7:23',
        'valor': '15 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 7:15',
        'valor': '22 KB',
        'precio': '0,00 €',
        'telf': '',
      },
      <String, String>{
        'tipo': 'Conexión datos',
        'fecha': '13/08/2021 - 0:09',
        'valor': '31 MB',
        'precio': '0,00 €',
        'telf': '',
      },
    ];

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(autoLeading: false, context: context, title: 'Consumo'),
      drawer: const MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(
            height: 1,
          ),
          itemCount: consume.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              minLeadingWidth: 12,
              tileColor: white,
              leading: (consume[i]['tipo'] == 'Conexión datos')
                  ? const Icon(Icons.public)
                  : const Icon(Icons.phone),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                    consume[i]['fecha'],
                    size: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: text(
                          (consume[i]['tipo'] == 'Llamada')
                              ? consume[i]['telf']
                              : consume[i]['tipo'],
                          size: 12,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                              consume[i]['valor'],
                              size: 12,
                            ),
                            text(
                              consume[i]['precio'],
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu),
      ),
    );
  }
}
