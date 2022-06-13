import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class WelcomeFormProvider extends ChangeNotifier {
  int _selectedForm = 0;

  set selectedForm(int i) {
    _selectedForm = i;
    notifyListeners();
  }

  int get selectedForm => _selectedForm;
}

/// LOGIN
class ValidateLoginProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool _isValidate = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isValidate => _isValidate;

  set isValidate(bool value) {
    _isValidate = value;
    notifyListeners();
  }

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}

/// SIGNUP
class ValidateSignupProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String password = '';
  String email = '';
  String account = '0';
  String invoice = '0.0';

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  clearForm() => formKey.currentState?.reset();
}
