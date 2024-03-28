import 'package:flutter/material.dart';

import '../services/responsive_service.dart';
import '../themes/palettes.dart';
import '../themes/typographies.dart';

extension BuildContextExtension on BuildContext {
  Size get maxSize => const Size(1440, 1080);
  NavigatorState get navigator => Navigator.of(this);
  Palettes get palettes => Theme.of(this).extension<Palettes>()!;
  ResponsiveService get responsive => ResponsiveService(this);
  RouteSettings get route => ModalRoute.of(this)!.settings;
  Size get screen => MediaQuery.sizeOf(this);
  Typographies get typographies => Theme.of(this).extension<Typographies>()!;
}
