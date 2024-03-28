import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/application/app.dart';
import 'src/application/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.initialize();
  if (kIsWeb) {
    // ignore: prefer_const_constructors
    setUrlStrategy(PathUrlStrategy());
  }
  runApp(const App(themeMode: ThemeMode.light));
}
