import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modules/home/views/home_view.dart';
import '../modules/initialize/views/splash_view.dart';
import '../modules/pokedex/views/pokedex_view.dart';

final class Routes {
  static String get initial => '/';
  static String get home => '/home';
  static String get pokedex => '$home/pokedex';

  static late Map<String, Widget Function(BuildContext context)> routes;

  static void initialize() {
    routes = <String, Widget Function(BuildContext)>{
      initial: (BuildContext context) => const SplashView(),
      home: (BuildContext context) => const HomeView(),
      pokedex: (BuildContext context) => const PokedexView(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final Widget Function(BuildContext)? navigateTo = routes[settings.name];

    if (navigateTo == null) {
      return null;
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => navigateTo.call(context),
        settings: settings,
      );
    }

    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => navigateTo.call(context),
      settings: settings,
    );
  }
}
