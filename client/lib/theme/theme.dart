import 'package:flutter/material.dart';

class ThemeGenerator {
  static const Color kThemeColor = Colors.deepOrange;
  static const double kBorderRadius = 24;

  static MaterialColor _materialColor() =>
      MaterialColor(kThemeColor.value, const {
        50: kThemeColor,
        100: kThemeColor,
        200: kThemeColor,
        300: kThemeColor,
        400: kThemeColor,
        500: kThemeColor,
        600: kThemeColor,
        700: kThemeColor,
        800: kThemeColor,
        900: kThemeColor,
      });

  static CheckboxThemeData get _checkBoxTheme => CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return kThemeColor;
            }
            return null;
          },
        ),
      );

  static TextTheme get _textTheme => Typography.blackCupertino;

  static ColorScheme get _colorScheme => ColorScheme.fromSwatch(
        primarySwatch: _materialColor(),
        brightness: Brightness.light,
      ).copyWith(secondary: kThemeColor);

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintStyle: TextStyle(color: Colors.grey.shade600),
        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: Colors.red);
          }
          if (states.contains(MaterialState.focused)) {
            return const TextStyle(color: kThemeColor);
          }
          return TextStyle(color: Colors.grey.shade600);
        }),
        labelStyle: TextStyle(color: Colors.grey.shade500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: kThemeColor, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
      );

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      );

  static TabBarTheme get _tabBarTheme => const TabBarTheme(
        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        labelColor: kThemeColor,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(color: Colors.transparent),
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      const FloatingActionButtonThemeData(foregroundColor: Colors.white);

  static SwitchThemeData get _switchTheme => SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return kThemeColor.withAlpha(100);
          }
          return Colors.grey.withAlpha(100);
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) return kThemeColor;
          return Colors.grey;
        }),
      );

  static AppBarTheme get _appBarTheme => const AppBarTheme(
        color: kThemeColor,
        shadowColor: Colors.black,
        elevation: 3,
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );

  static ThemeData generate() => ThemeData(
        colorScheme: _colorScheme,
        textTheme: _textTheme,
        checkboxTheme: _checkBoxTheme,
        textButtonTheme: _textButtonTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        appBarTheme: _appBarTheme,
        switchTheme: _switchTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        tabBarTheme: _tabBarTheme,
        snackBarTheme: _snackBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
      );
}
