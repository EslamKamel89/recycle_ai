import 'package:flutter/material.dart';
import 'package:recycle_ai/core/router/app_routes_names.dart';
import 'package:recycle_ai/core/router/middleware.dart';
import 'package:recycle_ai/core/screens_example/splash_screen/splash_screen.dart';
import 'package:recycle_ai/core/widgets/ui_components_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.uiComponentScreen:
        return CustomPageRoute(
          builder: (context) => const UiComponentScreen(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
