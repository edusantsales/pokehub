import 'package:flutter/material.dart';

import '../services/responsive_service.dart';
import '../themes/palettes.dart';
import '../themes/typographies.dart';

extension BuildContextExtension on BuildContext {
  Size get maxWidth => const Size.fromWidth(1440);
  NavigatorState get navigator => Navigator.of(this);
  Palettes get palettes => Theme.of(this).extension<Palettes>()!;
  ResponsiveService get responsive => ResponsiveService(this);
  RouteSettings get route => ModalRoute.of(this)!.settings;
  Size get screen => MediaQuery.sizeOf(this);
  Typographies get typographies => Theme.of(this).extension<Typographies>()!;
}
