import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/config/routes.dart';
import 'package:proyecto_dam/src/providers/prefix_provider.dart';
import 'package:proyecto_dam/src/providers/theme_provider.dart';
import 'package:proyecto_dam/src/services/auth_service.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PrefixProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'JorgePhone',
              theme: theme.getTheme(),
              builder: (context, widget) {
                return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(), child: widget!);
              },
              initialRoute: '/',
              routes: getRoutes(),
            ));
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
