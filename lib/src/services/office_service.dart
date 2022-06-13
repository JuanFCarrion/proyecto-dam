import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:proyecto_dam/src/models/office_model.dart';

class OfficeService extends ChangeNotifier {
  final List<Office> _offices = [];
  bool load = true;

  OfficeService() {
    loadDB();
    isLoading;
    notifyListeners();
  }

  set isLoading(bool value) {
    load = value;
  }

  bool get isLoading => load;

  Future loadDB() async {
    const _baseUrl =
        'jorgephone-4e16b-default-rtdb.europe-west1.firebasedatabase.app';
    final _url = Uri.https(_baseUrl, 'offices.json');
    final _resp = await http.get(_url);
    final _officeMap = json.decode(_resp.body);

    _officeMap.forEach((key, value) {
      final temp = Office.fromMap(value);
      temp.id = key;
      _offices.add(temp);
    });
    isLoading = false;

    return _offices;
  }
}
