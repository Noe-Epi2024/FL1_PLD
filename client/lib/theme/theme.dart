import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeGenerator {
  static const double kBorderRadius = 32;

  static const MaterialColor _monochromaticColor =
      MaterialColor(0xFF007ea7, <int, Color>{
    300: Color(0xFF80ced7),
    500: Color(0xFF007ea7),
    700: Color(0xFF003249),
  });

  static final Color _borderColor = Colors.grey.shade300;

  static final Color _hintColor = Colors.grey.shade500;

  static final Color _labelColor = Colors.grey.shade600;

  static CheckboxThemeData get _checkBoxTheme => CheckboxThemeData(
        shape: const CircleBorder(),
        side: BorderSide(color: _borderColor),
        fillColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return _colorScheme.primary;
            }
            return null;
          },
        ),
      );

  static TextTheme get _textTheme => GoogleFonts.latoTextTheme().copyWith(
        bodyLarge: GoogleFonts.lato(letterSpacing: 0),
      );

  static ColorScheme get _colorScheme => ColorScheme(
        background: const Color(0xFFF8F8F8),
        // background: Colors.white,
        onBackground: Colors.black,
        primary: _monochromaticColor.shade500,
        onPrimary: Colors.white,
        secondary: _monochromaticColor.shade300,
        onSecondary: Colors.white,
        tertiary: _monochromaticColor.shade700,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintStyle: _textTheme.bodyLarge!.copyWith(color: _hintColor),
        labelStyle: _textTheme.bodyLarge!.copyWith(color: _labelColor),
        prefixIconColor: _hintColor,
        suffixIconColor: _hintColor,
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: Colors.red);
          }
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: _colorScheme.primary);
          }
          return TextStyle(color: _labelColor);
        }),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: _colorScheme.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.red),
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
        labelStyle: _textTheme.bodyMedium!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: _textTheme.bodyMedium!.copyWith(fontSize: 12),
        labelColor: _colorScheme.primary,
        unselectedLabelColor: _labelColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          border:
              Border(top: BorderSide(color: _colorScheme.primary, width: 3)),
        ),
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      const FloatingActionButtonThemeData(foregroundColor: Colors.white);

  static SwitchThemeData get _switchTheme => SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return _colorScheme.primary.withAlpha(100);
          }
          return Colors.grey.withAlpha(100);
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return _colorScheme.primary;
          }
          return Colors.grey;
        }),
      );

  static AppBarTheme get _appBarTheme => AppBarTheme(
        surfaceTintColor: Colors.transparent,
        color: _colorScheme.surface,
        foregroundColor: _colorScheme.onSurface,
        elevation: 0,
        iconTheme: const IconThemeData(size: 20),
        shape: Border(bottom: BorderSide(color: _dividerTheme.color!)),
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          animationDuration: Duration.zero,
          textStyle: MaterialStatePropertyAll<TextStyle>(
            _textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return _colorScheme.tertiary;
            }
            return _colorScheme.primary;
          }),
          shadowColor:
              const MaterialStatePropertyAll<Color>(Colors.transparent),
          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          shape: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          animationDuration: Duration.zero,
          overlayColor:
              const MaterialStatePropertyAll<Color>(Colors.transparent),
          textStyle:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return _textTheme.bodyMedium!.copyWith(
                decorationColor: _colorScheme.primary,
              );
            }
            return _textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold);
          }),
        ),
      );

  static DividerThemeData get _dividerTheme =>
      DividerThemeData(color: _borderColor);

  static CardTheme get _cardTheme => CardTheme(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: _colorScheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _borderColor),
          borderRadius: BorderRadius.circular(kBorderRadius / 2),
        ),
      );

  static DialogTheme get _dialogTheme => DialogTheme(
        backgroundColor: _colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      );

  static DatePickerThemeData get _datePickerTheme => DatePickerThemeData(
        backgroundColor: _colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _dividerTheme.color!),
          borderRadius: BorderRadius.circular(16),
        ),
      );

  static ExpansionTileThemeData get _expansionTileTheme =>
      const ExpansionTileThemeData(shape: Border());

  static PopupMenuThemeData get _popupMenuTheme =>
      const PopupMenuThemeData(surfaceTintColor: Colors.transparent);

  static ThemeData generate() => ThemeData(
        cardTheme: _cardTheme,
        hintColor: _hintColor,
        dividerTheme: _dividerTheme,
        expansionTileTheme: _expansionTileTheme,
        dividerColor: _borderColor,
        splashColor: Colors.transparent,
        dialogBackgroundColor: _colorScheme.surface,
        dialogTheme: _dialogTheme,
        colorScheme: _colorScheme,
        textTheme: _textTheme,
        checkboxTheme: _checkBoxTheme,
        textButtonTheme: _textButtonTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        appBarTheme: _appBarTheme,
        switchTheme: _switchTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        tabBarTheme: _tabBarTheme,
        popupMenuTheme: _popupMenuTheme,
        snackBarTheme: _snackBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        datePickerTheme: _datePickerTheme,
      );
}
