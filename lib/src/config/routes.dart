import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/pages/pages.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (_) => const Slash(),
    'welcome': (_) => const LoginPage(),
    'login': (_) => const LoginPage(),
    'resume': (_) => ResumePage(),
    'consume': (_) => const ConsumePage(),
    'invoices': (_) => const InvoicesPage(),
    'offices': (_) => const OfficesPage(),
    'settings': (_) => const SettingsPage(),
    'help': (_) => const HelpPage(),
  };
}
