import 'package:flutter/material.dart';
import 'package:test_project/model/product_model.dart';
import 'package:test_project/screens/home/home_screen.dart';
import 'package:test_project/screens/product_details_screen.dart';
import 'package:test_project/utilities/routes/routes.dart';
import 'package:test_project/widgets/invaid_route.dart';

Route<dynamic>? onGenerateRoute(RouteSettings? settings) {
  late Widget widget;
  SlideType slideType = SlideType.ltr;
  switch (settings?.name) {
    case Routes.home:
      widget = const HomeScreen();
    case Routes.productDetails:
      widget =
          ProductDetailsScreen(product: settings?.arguments as ProductModel);
    default:
      widget = const InvalidRoute();
  }
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (c, _, __) {
      return widget;
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        SlideTransition(
      position: getOffset(slideType).animate(animation),
      child: child,
    ),
  );
}

Tween<Offset> getOffset(SlideType slidesType) {
  switch (slidesType) {
    case SlideType.btt:
      return Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      );
    case SlideType.ltr:
    case SlideType.ttb:
    default:
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      );
  }
}

enum SlideType { ltr, btt, ttb }
