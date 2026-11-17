import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const double tablet = 720;
  static const double desktop = 1100;

  static double widthOf(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) => widthOf(context) < tablet;

  static bool isDesktop(BuildContext context) => widthOf(context) >= desktop;
}
