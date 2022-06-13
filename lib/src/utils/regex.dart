import 'package:proyecto_dam/src/constants/constant.dart';

String? matchPassword(value) {
  RegExp regExp = RegExp(regexPassword);
  return regExp.hasMatch(value ?? '') ? null : 'Faltan caracteres';
}

String? matchDni(value) {
  RegExp regExpDNI = RegExp(regexDNI);
  RegExp regExpCIF = RegExp(regexCIF);
  RegExp regExpNIE = RegExp(regexNIE);
  return (regExpDNI.hasMatch(value ?? '') ||
          regExpCIF.hasMatch(value ?? '') ||
          regExpNIE.hasMatch(value ?? ''))
      ? null
      : 'Ej. 12345678A';
}

String? matchEmail(value) {
  RegExp regExp = RegExp(regexEmail);
  return regExp.hasMatch(value ?? '') ? null : 'Ej. nombre@email.es';
}

String? matchAccount(value) {
  RegExp regExp = RegExp(regexAccount);
  return regExp.hasMatch(value ?? '') ? null : 'Ej. 1234';
}

String? matchInvoice(value) {
  RegExp regExp = RegExp(regexInvoice);
  return regExp.hasMatch(value ?? '') ? null : 'Ej. 9.99';
}
