import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class ThemeGenerator {
  static const double kBorderRadius = 32;

  static CheckboxThemeData get _checkBoxTheme => CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return _colorScheme.primary;
            }
            return null;
          },
        ),
      );

  static TextTheme get _textTheme => GoogleFonts.openSansTextTheme();

  static ColorScheme get _colorScheme => const ColorScheme(
        background: Color(0xFFF2F1F7),
        onBackground: Colors.black,
        primary: Color(0xFFFF7F11),
        onPrimary: Colors.white,
        secondary: Color(0xFF1191FF),
        onSecondary: Colors.white,
        tertiary: Color(0xFFFF973C),
        onTertiary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
      );

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
            return TextStyle(color: _colorScheme.primary);
          }
          return TextStyle(color: Colors.grey.shade600);
        }),
        labelStyle: TextStyle(color: Colors.grey.shade500, letterSpacing: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: _colorScheme.primary, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
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

  static TabBarTheme get _tabBarTheme => TabBarTheme(
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        labelColor: _colorScheme.primary,
        unselectedLabelColor: Colors.black,
        indicator: const BoxDecoration(color: Colors.transparent),
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      const FloatingActionButtonThemeData(foregroundColor: Colors.white);

  static SwitchThemeData get _switchTheme => SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return _colorScheme.primary.withAlpha(100);
          }
          return Colors.grey.withAlpha(100);
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected))
            return _colorScheme.primary;
          return Colors.grey;
        }),
      );

  static AppBarTheme get _appBarTheme => AppBarTheme(
        surfaceTintColor: Colors.transparent,
        color: _colorScheme.surface,
        shape:
            Border(bottom: BorderSide(width: .5, color: _dividerTheme.color!)),
        shadowColor: Colors.transparent,
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          animationDuration: Duration.zero,
          overlayColor: null,
          textStyle: MaterialStatePropertyAll(
            _textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered))
              return _colorScheme.tertiary;
            return _colorScheme.primary;
          }),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          animationDuration: Duration.zero,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered))
              return _textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 4,
                decorationColor: _colorScheme.primary,
              );
            return _textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold);
          }),
        ),
      );

  static DividerThemeData get _dividerTheme =>
      DividerThemeData(color: Colors.grey.shade500);

  static ThemeData generate() => ThemeData(
        dividerTheme: _dividerTheme,
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
