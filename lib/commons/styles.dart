import 'package:material_ui/material_ui.dart';

abstract final class ThemeColors {
  static const Color white = Color(0xFFFAFBFA);
  static const Color blue = Color(0xFF009FFB);
  static const Color green = Color(0xFF2AAF02);
  static const Color red = Color(0xFFF30146);
  static const Color yellow = Color(0xFFFE931C);
  static const Color gray = Color(0xFF5F5E5E);
  static const Color grayLight = Color(0xFF8A8989);
  static const Color grayLight2 = Color(0xFFEBEBE5);
  static const Color ink = Color(0xFF2B2B2B);
}

abstract final class ThemeText {
  static const TextStyle display = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: ThemeColors.yellow,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: ThemeColors.ink,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: ThemeColors.gray,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: ThemeColors.gray,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: ThemeColors.ink,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

ThemeData buildAppTheme() {
  const scheme = ColorScheme(
    brightness: Brightness.light,
    primary: ThemeColors.yellow,
    onPrimary: Colors.white,
    secondary: ThemeColors.blue,
    onSecondary: Colors.white,
    error: ThemeColors.red,
    onError: Colors.white,
    surface: ThemeColors.white,
    onSurface: ThemeColors.ink,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: ThemeColors.grayLight2,
    fontFamily: 'Poppins',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.yellow,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: ThemeColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFE4E2DA)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ThemeColors.yellow,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: ThemeText.label,
      floatingLabelStyle: ThemeText.label.copyWith(color: ThemeColors.yellow),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD9D7CF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ThemeColors.yellow, width: 2),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: ThemeText.display,
      titleLarge: ThemeText.title,
      titleMedium: ThemeText.label,
      bodyLarge: ThemeText.body,
      bodyMedium: ThemeText.subtitle,
    ),
  );
}
