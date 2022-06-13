import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:proyecto_dam/src/models/invoice_model.dart';

export 'package:provider/provider.dart';

class PdfService extends ChangeNotifier {
  List<Invoice> invoices = [];
  bool _isLoading = false;

  PdfService() {
    loadDB();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<List<Invoice>> loadDB() async {
    _isLoading = true;

    invoices = [
      Invoice(
        date: 'Julio 2022',
        path: 'assets/pdf/Julio 2022.pdf',
      ),
      Invoice(
        date: 'Agosto 2022',
        path: 'assets/pdf/Agosto 2022.pdf',
      )
    ];

    return invoices;
  }

  Future loadPdfFromAssets({required String path}) async {
    _isLoading = true;
    // PDFDocument pdf = await PDFDocument.fromAsset(path)
    //   ..preloadPages();

    // return pdf;
  }

  Future loadPdfFromUrl({required String path}) async {
    _isLoading = true;
    // PDFDocument pdf = await PDFDocument.fromURL(path)
    //   ..preloadPages();

    // return pdf;
  }
}
