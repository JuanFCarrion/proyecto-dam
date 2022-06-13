import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/widgets/arc.dart';
import 'package:proyecto_dam/src/widgets/count.dart';
import 'package:proyecto_dam/src/widgets/drawer.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class ResumePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(autoLeading: false, context: context),
      drawer: const MenuLateral(),
      body: const _ResumePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu),
      ),
    );
  }
}

class _ResumePage extends StatefulWidget {
  const _ResumePage({Key? key}) : super(key: key);

  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<_ResumePage> {
  @override
  Widget build(BuildContext context) {
    double available = 65;
    double fee = 48;

    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _Consume(available: available, fee: fee),
          const _Gasto(),
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(microseconds: 750));
    setState(() {});
    return;
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.widget,
    required this.title,
  }) : super(key: key);

  final Widget widget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: greyBackground2,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: redLetter,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: text(
              title,
              centered: true,
              color: white,
              bold: true,
              size: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: widget,
          ),
        ],
      ),
    );
  }
}

class _Consume extends StatelessWidget {
  const _Consume({
    Key? key,
    required this.available,
    required this.fee,
  }) : super(key: key);

  final double available;
  final double fee;

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'CONSUMO DE DATOS',
      widget: Column(
        children: [
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                ProgressiveArc(
                  percentage: available,
                  duration: 1250,
                  reverseDuration: 1750,
                  backgroundColor: redLogo, //Color(0xff1662ab),
                  color: lightOrangeBackground,
                  thickness: 18,
                  strokeCap: StrokeCap.square,
                  // startAngle: 160,
                  startAngle: 270,
                  // sweepAngle: 220,
                  sweepAngle: 360,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProgressiveCount(
                        percentage: available,
                        maxValue: fee,
                        duration: 1250,
                        reverseDuration: 1750,
                        size: 34,
                        textColor: greyLetter,
                        bold: false,
                      ),
                      text(
                        'DISPONIBLES DE',
                        size: 16,
                        color: greyLetterSecundary,
                        maxLine: 2,
                        centered: true,
                      ),
                      text(
                        '${fee.toInt()}GB',
                        size: 22,
                        color: redLetter,
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {},
            child: text(
              '> Necesito un bono extra de datos <',
              color: redButtons2,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _Gasto extends StatelessWidget {
  const _Gasto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'GASTO MENSUAL',
      widget: Column(
        children: [
          const SizedBox(height: 15),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text(
                'Del 1 al 15 de Agosto',
                centered: true,
                // color: white,
              ),
              text(
                '35,00€', centered: true, size: 30,
                color: redLetter,
                bold: true,
                // color: darkBlueLetter,
              ),
              text(
                'Impuestos Incluidos', centered: true, size: 12,
                // color: white,
                // color: darkBlueLetter,
              ),
            ],
          ),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Incluido en mi tarifa:', size: 12, bold: true),
              text('35,00€', size: 12),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Llamadas', size: 14),
              text('128 min / Ilimitados', size: 14, bold: true)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Datos', size: 14),
              text('16,80GB / 48GB', size: 14, bold: true),
            ],
          ),

          // SizedBox(height: 10),
          // InkWell(
          //   onTap: () {},
          //   child: text('> Quiero mejorar mi tarifa <',
          //       color: blueButtons2, size: 14),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     text('35,00€', size: 12),
          //   ],
          // ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Bonos:', size: 12, bold: true),
              text('0€', size: 12),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Llamadas internacionales', size: 14),
              text('0 min / 0 min', size: 14, bold: true)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text('Datos', size: 14),
              text('0GB / 0GB', size: 14, bold: true),
            ],
          ),
          const SizedBox(height: 12),
          // InkWell(
          //   onTap: () {},
          //   child:
          //       text('> Quiero un bono <', color: blueButtons2, size: 14),
          // ),
          InkWell(
            onTap: () {},
            child: text('> Quiero mejorar mi tarifa <',
                color: redButtons2, size: 14),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     text('0€', size: 12),
          //   ],
          // ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
