import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:proyecto_dam/src/widgets/widgets.dart';

class PdfInvoice extends StatefulWidget {
  const PdfInvoice(this.selected, {Key? key}) : super(key: key);
  final String selected;

  @override
  State<PdfInvoice> createState() => _PdfInvoiceState();
}

class _PdfInvoiceState extends State<PdfInvoice> {
  PDFDocument? doc;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    // if (widget.selected != 'Junio 2022') {
    //   doc = await PDFDocument.fromAsset('assets/pdf/junio.pdf');
    // } else {
    doc = await PDFDocument.fromAsset('assets/pdf/${widget.selected}.pdf');

    // }
    // doc!.preloadPages();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: widget.selected,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              return showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(
                    const Duration(seconds: 1),
                  ).then((_) => Navigator.of(context).pop());
                  return AlertDialog(
                    title: text('Descargando...', centered: true),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: doc!,
                  showPicker: false,
                  zoomSteps: 1,
                  lazyLoad: false,
                  // scrollDirection: Axis.vertical
                ),
        ),
      ),
    );
  }
}
