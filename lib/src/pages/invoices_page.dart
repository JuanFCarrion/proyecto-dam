import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/models/invoice_model.dart';
import 'package:proyecto_dam/src/pages/invoices_sections/pdf_invoice.dart';
import 'package:proyecto_dam/src/services/pdf_service.dart';
import 'package:proyecto_dam/src/widgets/drawer.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PdfService(),
      child: const ShowList(),
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  var selectedItem = 'Junio 2022';
  @override
  Widget build(BuildContext context) {
    // final listInvoice = PdfService().loadDB();

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List invoices = [
      Invoice(
        date: 'Agosto 2022',
        path: 'assets/pdf/junio.pdf',
      ),
      Invoice(
        date: 'Julio 2022',
        path: 'assets/pdf/mayo.pdf',
      ),
      Invoice(
        date: 'Junio 2022',
        path: 'assets/pdf/junio.pdf',
      ),
      Invoice(
        date: 'Mayo 2022',
        path: 'assets/pdf/mayo.pdf',
      ),
      Invoice(
        date: 'Abril 2022',
        path: 'assets/pdf/junio.pdf',
      )
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar(
          autoLeading: false,
          context: context,
          title: 'Facturas',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Historial'),
              Tab(text: 'Gráficos'),
            ],
          ),
        ),
        drawer: const MenuLateral(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          child: const Icon(Icons.menu),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: invoices.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  tileColor: white,
                  leading: const Icon(Icons.description_outlined),
                  minLeadingWidth: 12,
                  title: text(invoices[i].date),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: greyLetter,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfInvoice(invoices[i].date),
                    ),
                  ),
                );
              },
            ),
            const _Charts(),
          ],
        ),
      ),
    );
  }
}

class _Charts extends StatelessWidget {
  const _Charts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        const SizedBox(
          // height: screen.height * 0.1,
          child: _DropDownButton(),
        ),
        Container(
          color: white,
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 70),
          child: Column(
            children: [
              text('Llamadas (Minutos)', size: 14),
              SizedBox(
                  height: screen.height * 0.4,
                  child: GroupedBarTargetLineChart.withSampleData()),
            ],
          ),
        ),
        SizedBox(height: screen.height * 0.01),
        Container(
          color: white,
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 70),
          child: Column(
            children: [
              text('Datos (GB)', size: 14),
              SizedBox(
                  height: screen.height * 0.4,
                  child: GroupedBarTargetLineChart2.withSampleData()),
            ],
          ),
        ),
        SizedBox(height: screen.height * 0.1),
      ],
    );
  }
}

class _DropDownButton extends StatefulWidget {
  const _DropDownButton({Key? key}) : super(key: key);

  @override
  __DropDownButtonState createState() => __DropDownButtonState();
}

class __DropDownButtonState extends State<_DropDownButton> {
  @override
  Widget build(BuildContext context) {
    List years = ['2022', '2021'];
    String _currentSelectedItem = '2022';
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: greyLetterSecundary,
                blurRadius: 4.0,
                spreadRadius: 0.5,
                offset: Offset(0.50, 0.5),
              ),
            ],
          ),
          padding: const EdgeInsets.only(left: 44.0, right: 35),
          margin: const EdgeInsets.only(bottom: 8),
          child: DropdownButton(
            elevation: 6,
            isExpanded: true,
            items: years.map(
              (val) {
                return DropdownMenuItem(
                  value: val,
                  child: text(val),
                );
              },
            ).toList(),
            value: _currentSelectedItem,
            onChanged: (value) {
              setState(() {
                _currentSelectedItem = value.toString();
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15.0, left: 12.0),
          child: const Icon(
            Icons.calendar_today,
            color: redButtons2,
            size: 20.0,
          ),
        ),
      ],
    );
  }
}

class GroupedBarTargetLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const GroupedBarTargetLineChart(this.seriesList,
      {Key? key, required this.animate})
      : super(key: key);

  factory GroupedBarTargetLineChart.withSampleData() {
    return GroupedBarTargetLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      // defaultInteractions: true,

      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 270,
          labelOffsetFromTickPx: -8,
          // labelOffsetFromAxisPx: 0,
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ), //90 or 270 to make it vertical
      barGroupingType: charts.BarGroupingType.stacked,
      customSeriesRenderers: [
        charts.BarTargetLineRendererConfig<String>(
          // ID used to link series to this renderer.
          customRendererId: 'customTargetLine',
          groupingType: charts.BarGroupingType.grouped,
        ),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<PhoneChart, String>> _createSampleData() {
    final phoneChartData = [
      PhoneChart('Enero', 88),
      PhoneChart('Febrero', 143),
      PhoneChart('Marzo', 112),
      PhoneChart('Abril', 155),
      PhoneChart('Mayo', 97),
      PhoneChart('Junio', 128),
      PhoneChart('Julio', 75),
      PhoneChart('Agosto', 68),
      PhoneChart('Septiembre', 0),
      PhoneChart('Octubre', 0),
      PhoneChart('Noviembre', 0),
      PhoneChart('Diciembre', 0),
    ];

    return [
      charts.Series<PhoneChart, String>(
        id: '2022',
        domainFn: (chart, _) => chart.month,
        measureFn: (chart, _) => chart.min,
        data: phoneChartData,
        labelAccessorFn: (chart, _) => chart.min.toString(),
      ),
    ];
  }
}

class PhoneChart {
  final String month;
  final int min;

  PhoneChart(this.month, this.min);
}

class GroupedBarTargetLineChart2 extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const GroupedBarTargetLineChart2(this.seriesList,
      {Key? key, required this.animate})
      : super(key: key);

  factory GroupedBarTargetLineChart2.withSampleData() {
    return GroupedBarTargetLineChart2(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 270,
          labelOffsetFromTickPx: -8,
          // labelOffsetFromAxisPx: 0,
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ), //90 or 270 to make it vertical
      barGroupingType: charts.BarGroupingType.stacked,
      customSeriesRenderers: [
        charts.BarTargetLineRendererConfig<String>(
          // ID used to link series to this renderer.
          customRendererId: 'customTargetLine',
          groupingType: charts.BarGroupingType.grouped,
        ),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<InternetChart, String>> _createSampleData() {
    final internetChartData = [
      InternetChart('Enero', 38),
      InternetChart('Febrero', 23),
      InternetChart('Marzo', 12),
      InternetChart('Abril', 24),
      InternetChart('Mayo', 17),
      InternetChart('Junio', 28),
      InternetChart('Julio', 32),
      InternetChart('Agosto', 18),
      InternetChart('Septiembre', 0),
      InternetChart('Octubre', 0),
      InternetChart('Noviembre', 0),
      InternetChart('Diciembre', 0),
    ];

    return [
      charts.Series<InternetChart, String>(
        id: '2022',
        domainFn: (InternetChart sales, _) => sales.month,
        measureFn: (InternetChart sales, _) => sales.gb,
        data: internetChartData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class InternetChart {
  final String month;
  final int gb;

  InternetChart(this.month, this.gb);
}
