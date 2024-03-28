import 'package:flutter/material.dart';

import 'routes/routes.dart';
import 'themes/palettes.dart';
import 'themes/typographies.dart';

final class App extends StatelessWidget {
  const App({
    super.key,
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[Palettes.dark, Typographies.inter],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      onGenerateRoute: Routes.onGenerateRoute,
      routes: Routes.routes,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[Palettes.light, Typographies.inter],
      ),
      themeMode: themeMode,
      title: 'Poke Hub',
    );
  }
}
