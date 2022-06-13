import 'package:flutter/material.dart';
import 'package:proyecto_dam/src/constants/texts.dart';

class PrefixProvider extends ChangeNotifier {
  final Map<String, String> _prefijos = {
    spain: '+34 ',
   france: '+33 ',
    portugal: '+351 ',
    germany: '+49',
  };
  String _pais = spain;

  set pais(String pais) {
    _pais = pais;
    notifyListeners();
  }

  String get pais => _pais;

  Map<String, String> get prefijos => _prefijos;
}
